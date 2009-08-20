//
//  PlayerTest.m
//  Tack
//
//  Created by Stig Brautaset on 05/07/2009.
//  Copyright 2009 Stig Brautaset. All rights reserved.
//



#import "Player.h"
#import "Piece.h"

#import <SenTestingKit/SenTestingKit.h>

@interface PlayerTest : SenTestCase
@end

@implementation PlayerTest

- (void) testCopy {
    NSString *name = @"One";    
    Player *one = [[Player alloc] initWithName:name];
    Player *two = [one copy];
    STAssertNotNil(two, nil);
    STAssertEqualObjects(two.name, name, nil);
}

@end
