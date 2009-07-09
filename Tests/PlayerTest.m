//
//  PlayerTest.m
//  Tack
//
//  Created by Stig Brautaset on 05/07/2009.
//  Copyright 2009 Stig Brautaset. All rights reserved.
//

#import "PlayerTest.h"
#import "Player.h"
#import "Piece.h"


@implementation PlayerTest

- (void) testCopy {
    NSString *name = @"One";
    Piece *a = [Piece new];
    
    Player *one = [[Player alloc] initWithName:name];
    [one.pieces addObject:a];
    
    Player *two = [one copy];
    STAssertNotNil(two, nil);
    STAssertEqualObjects(two.name, name, nil);
    STAssertEqualObjects([two.pieces anyObject], a, nil);

    // check that set of pieces is individual from now on
    [one.pieces addObject:[Piece new]];
    STAssertEquals([one.pieces count], (NSUInteger)2, nil);
    STAssertEquals([two.pieces count], (NSUInteger)1, nil);
    
    [one.pieces removeObject:a];
    STAssertEquals([one.pieces count], (NSUInteger)1, nil);
    STAssertEquals([two.pieces count], (NSUInteger)1, nil);
}

@end
