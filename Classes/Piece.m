//
//  Piece.m
//  Tick
//
//  Created by Stig Brautaset on 05/07/2009.
//  Copyright 2009 Stig Brautaset. All rights reserved.
//

#import "Piece.h"

@implementation Piece

@synthesize location;
@synthesize owner;

- (id)copyWithZone:(NSZone*)zone {
    Piece *copy = [[self class] new];
    copy.location = self.location;
    copy.owner = self.owner;
    return copy;
}

- (BOOL)isEqual:(id)obj {
    return [obj isMemberOfClass:[self class]]
        && [self.location isEqual:[obj location]]
        && [self.owner isEqual:[obj owner]];
}

- (NSUInteger)hash {
    return [location hash] + [owner hash];
}

@end
