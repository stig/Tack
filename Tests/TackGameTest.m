//
//  TackControllerTest.m
//  Tack
//
//  Created by Stig Brautaset on 09/07/2009.
//  Copyright 2009 Stig Brautaset. All rights reserved.
//

#import "TackGame.h"
#import "Board.h"
#import "Player.h"
#import "Piece.h"
#import "Location.h"

#import <SenTestingKit/SenTestingKit.h>

@interface TackGameTest : SenTestCase {
    TackGame *game;
    NSMutableArray *observed;
}
@end

@implementation TackGameTest

- (void)setUp {
    Player *me = [[Player alloc] initWithName:@"me"];
    Player *you = [[Player alloc] initWithName:@"you"];
    game = [[TackGame alloc] initWithPlayerOne:me two:you];
    observed = [NSMutableArray new];
}

- (void)testLegalMoves {
    NSArray *moves;
    STAssertNotNil(moves = [game legalMoves], nil);
    STAssertEquals(moves.count, 9u, nil);
    
    NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(4, 4)];
    NSArray *taken = [moves objectsAtIndexes:indexes];
    
    for (Location *loc in taken) {
        [game performMove:loc];
    }
    
    STAssertNotNil(moves = [game legalMoves], nil);
    STAssertEquals(moves.count, 5u, nil);
    
    NSSet *moveSet = [NSSet setWithArray:moves];
    NSSet *takenSet = [NSSet setWithArray:taken];
    STAssertFalse([moveSet intersectsSet:takenSet], nil);
}


- (void)testFitness {    
    STAssertEquals([game fitness], 0, nil);

    [game performMove:[Location locationWithColumn:0 row:0]];
    STAssertEquals([game fitness], -3, nil);
    
    [game performMove:[Location locationWithColumn:0 row:1]];
    STAssertEquals([game fitness], 1, nil);
    
    [game performMove:[Location locationWithColumn:1 row:1]];
    STAssertEquals([game fitness], -14, nil);
}


- (void)testMove {
    Location *origin = [Location locationWithColumn:0 row:0];
    
    [game performMove:origin];
    
    STAssertEquals([[game.board pieceAtLocation:origin] owner], [game opponent], nil);
    STAssertThrows([game performMove:origin], nil);
}


- (void)testUndo {
    Location *origin = [Location locationWithColumn:0 row:0];
    
    STAssertThrows([game undoMove:origin], nil);
    [game performMove:origin];    
    [game undoMove:origin];
    
    STAssertNil([game.board pieceAtLocation:origin], nil);
}

- (void)testGameOverAtWin {
    STAssertFalse([game isGameOver], nil);
    [game performMove:[Location locationWithColumn:0 row:0]];
    [game performMove:[Location locationWithColumn:1 row:0]];

    [game performMove:[Location locationWithColumn:1 row:1]];
    [game performMove:[Location locationWithColumn:2 row:1]];
    
    [game performMove:[Location locationWithColumn:2 row:2]];
    STAssertTrue([game isGameOver], nil);
    STAssertEqualObjects([game legalMoves], [NSArray array], nil);
}

- (void)testGameOverAtDraw {
    STAssertFalse([game isGameOver], nil);
    [game performMove:[Location locationWithColumn:0 row:0]];
    [game performMove:[Location locationWithColumn:1 row:0]];
    
    [game performMove:[Location locationWithColumn:0 row:1]];
    [game performMove:[Location locationWithColumn:1 row:1]];

    [game performMove:[Location locationWithColumn:1 row:2]];
    [game performMove:[Location locationWithColumn:0 row:2]];

    [game performMove:[Location locationWithColumn:2 row:0]];
    [game performMove:[Location locationWithColumn:2 row:1]];

    [game performMove:[Location locationWithColumn:2 row:2]];
    STAssertTrue([game isGameOver], nil);
}

- (void)testGameOverWeirdness {
    STAssertFalse([game isGameOver], nil);
    [game performMove:[Location locationWithColumn:0 row:0]];
    [game performMove:[Location locationWithColumn:1 row:0]];
    [game performMove:[Location locationWithColumn:2 row:0]];
    
    [game performMove:[Location locationWithColumn:1 row:1]];
    [game performMove:[Location locationWithColumn:2 row:1]];
    
    [game performMove:[Location locationWithColumn:0 row:2]];
    [game performMove:[Location locationWithColumn:1 row:2]];
    
    NSLog(@"isGameOver?");
    STAssertFalse([game isGameOver], nil);
    
}

#pragma mark Searching

- (void)testMoveSearchWithDepthFromPly0 {
    Location *center = [Location locationWithColumn:1 row:1];
    for (int i = 0; i < 4; i++) {
        Location *move = [game moveFromSearchToDepth:i];
        STAssertEqualObjects(move, center, nil);
    }
}

- (void)testMoveSearchWithDepthFromPly1 {
    [game performMove:[Location locationWithColumn:1 row:1]];

    Location *corner = [game moveFromSearchToDepth:0];
    for (int i = 0; i < 4; i++) {
        Location *move = [game moveFromSearchToDepth:i];
        STAssertEqualObjects(move, corner, nil);
    }
}


#pragma mark Observing

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{    
    [observed addObject:context];
}

- (void)testObserving {
    [game performMove:[Location locationWithColumn:0 row:0]];
    [game.board addObserver:self];
    
    Location *foo = [Location locationWithColumn:0 row:1];
    [game performMove:foo];

    Location *bar = [Location locationWithColumn:0 row:2];
    [game performMove:bar];
    
    STAssertEquals(observed.count, 2u, nil);
    STAssertEqualObjects([observed objectAtIndex:0], foo, nil);
    STAssertEqualObjects([observed objectAtIndex:1], bar, nil);
}

@end
