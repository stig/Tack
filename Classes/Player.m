//
//  Player.m
//  Tick
//
//  Created by Stig Brautaset on 05/07/2009.
//  Copyright 2009 Stig Brautaset. All rights reserved.
//

#import "Player.h"


@implementation Player

@synthesize name;
@synthesize pieces;

- (id)initWithName:(NSString*)n {
    self = [super init];
    if (self) {
        pieces = [NSMutableSet new];
        self.name = n;
    }
    return self;
}

- (id)init {
    return [self initWithName:@"Unknown"];
}

- (id)copyWithZone:(NSZone*)zone {
    Player *copy = [[[self class] alloc] initWithName:self.name];
    copy.pieces = [pieces mutableCopy];
    return copy;
}

- (BOOL)isEqual:(id)obj {
    return [obj isMemberOfClass:[self class]]
        && [[obj name] isEqual:self.name];
}

- (NSUInteger)hash {
    return [name hash];
}

@end
