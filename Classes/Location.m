//
//  Location.m
//  Tack
//
//  Created by Stig Brautaset on 05/07/2009.
//  Copyright 2009 Stig Brautaset. All rights reserved.
//

#import "Location.h"

#define MAX_DIM 8
NSMutableArray *_cache;

@implementation Location

@synthesize column, row;

+ (void)initialize {
	NSLog(@"%s", _cmd);

	_cache = [[NSMutableArray alloc] initWithCapacity: MAX_DIM * MAX_DIM];
	for (int i = 0; i < MAX_DIM; i++)
		for (int j = 0; j < MAX_DIM; j++)
			[_cache addObject:[[Location alloc] initWithColumn:i row:j]];
}


+ (id)locationWithColumn:(NSUInteger)c row:(NSUInteger)r {
	NSParameterAssert(c < MAX_DIM && r < MAX_DIM);
	return [_cache objectAtIndex:c * MAX_DIM + r];
}

- (id)initWithColumn:(NSUInteger)c row:(NSUInteger)r {
	NSParameterAssert(c < MAX_DIM && r < MAX_DIM);
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
    return self.column * MAX_DIM + self.row;
}

@end
