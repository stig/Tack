//
//  Location.m
//  Tack
//
//  Created by Stig Brautaset on 05/07/2009.
//  Copyright 2009 Stig Brautaset. All rights reserved.
//

#import "Location.h"


@implementation Location

@synthesize column, row;

+ (id)locationWithColumn:(NSUInteger)c row:(NSUInteger)r {
    return [[self alloc] initWithColumn:c row:r];
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
   return [[[self class] alloc] initWithColumn:self.column
                                           row:self.row];
}

#pragma mark description

- (NSString*)description {
    return [NSString stringWithFormat:@"[%u,%u]", self.column, self.row];
}

#pragma mark equality

- (BOOL)isEqual:(id)obj {
    return [obj isMemberOfClass:[self class]]
        && [self hash] == [obj hash];
}


// A 100x100 board is probably enough.
- (NSUInteger)hash {
    return self.column * 100 + self.row;
}

@end
