//
//  Player.m
//  Tick
//
//  Created by Stig Brautaset on 05/07/2009.
//  Copyright 2009 Morgan Stanley. All rights reserved.
//

#import "Player.h"


@implementation Player

@synthesize name;
@synthesize pieces;
@synthesize colour;

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


@end
