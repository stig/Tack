//
//  Location.m
//  Tack
//
//  Created by Stig Brautaset on 05/07/2009.
//  Copyright 2009 Stig Brautaset. All rights reserved.
//

#import "Location.h"

#define CACHE_DIM 3
NSMutableArray *_cache;

@implementation Location

@synthesize column, row;

+ (void)initialize {
	_cache = [[NSMutableArray alloc] initWithCapacity: CACHE_DIM * CACHE_DIM];
	
	for (int i = 0; i < CACHE_DIM; i++)
		for (int j = 0; j < CACHE_DIM; j++) {
			Location *loc = [[Location alloc] initWithColumn:i row:j];
			[_cache addObject:loc];
			[loc release];
		}
}

+ (id)locationWithColumn:(NSUInteger)c row:(NSUInteger)r {
	if (c < CACHE_DIM && r < CACHE_DIM)
		return [_cache objectAtIndex:c * CACHE_DIM + r];
	return [[[self alloc] initWithColumn:c row:r] autorelease];
}

- (id)initWithColumn:(NSUInteger)c row:(NSUInteger)r {
    self = [super init];
    if (self) {
        row = r;
        column = c;
    }
    return self;
}

- (id)init {
    NSAssert(0, @"You should call -initWithColumn:row: rather than -init");
    return nil;
}

- (id)copyWithZone:(NSZone*)zone {
	return [self retain];
}

#pragma mark description

- (NSString*)description {
    return [NSString stringWithFormat:@"%u@%u", self.column, self.row];
}

#pragma mark equality

- (BOOL)isEqual:(id)obj {
    return (id)self == obj || [obj isMemberOfClass:[Location class]] && [self hash] == [obj hash];
}


// A 100x100 board is probably enough.
- (NSUInteger)hash {
    return self.column * CACHE_DIM + self.row;
}

@end
