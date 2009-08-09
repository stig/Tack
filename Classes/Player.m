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
    return [[[self class] alloc] initWithName:self.name];
}

- (BOOL)isEqual:(id)obj {
    return [obj isMemberOfClass:[self class]]
        && [[obj name] isEqual:self.name];
}

- (NSUInteger)hash {
    return [name hash];
}

@end
