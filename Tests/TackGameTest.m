//
//  TackControllerTest.m
//  Tack
//
//  Created by Stig Brautaset on 09/07/2009.
//  Copyright 2009 Stig Brautaset. All rights reserved.
//

#import "TackGameTest.h"
#import "TackGame.h"
#import "Board.h"
#import "Player.h"
#import "Piece.h"
#import "Location.h"

@implementation TackGameTest

- (void)setUp {
    game = [[TackGame alloc] init];
    board = game.board;
    observed = [NSMutableArray new];
}

- (void)testLegalMoves {
    NSArray *moves;
    STAssertNotNil(moves = [game legalMoves], nil);
    STAssertEquals(moves.count, 9u, nil);
    
    NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(4, 4)];
    NSArray *taken = [moves objectsAtIndexes:indexes];
    
    for (Location *loc in taken) {
        [board setPiece:@"occupied" atLocation:loc];
    }
    
    STAssertNotNil(moves = [game legalMoves], nil);
    STAssertEquals(moves.count, 5u, nil);
    
    NSSet *moveSet = [NSSet setWithArray:moves];
    NSSet *takenSet = [NSSet setWithArray:taken];
    STAssertFalse([moveSet intersectsSet:takenSet], nil);
}


- (void)testFitness {
    Player *me = [[Player alloc] initWithName:@"me"];
    Player *you = [[Player alloc] initWithName:@"you"];
    
    STAssertEquals([game fitnessForPlayer:me withOpponent:you], 0, nil);

    Piece *p = [Piece new];
    p.owner = me;
    p.location = [Location locationWithColumn:0 row:0];
    [board setPiece:p atLocation:p.location];
    STAssertEquals([game fitnessForPlayer:me withOpponent:you], 3, nil);
    STAssertEquals([game fitnessForPlayer:you withOpponent:me], -3, nil);

    p = [Piece new];	
    p.owner = you;
    p.location = [Location locationWithColumn:0 row:1];
    [board setPiece:p atLocation:p.location];
    STAssertEquals([game fitnessForPlayer:me withOpponent:you], 1, nil);
    STAssertEquals([game fitnessForPlayer:you withOpponent:me], -1, nil);
    
    p = [Piece new];
    p.owner = me;
    p.location = [Location locationWithColumn:1 row:1];
    [board setPiece:p atLocation:p.location];
    STAssertEquals([game fitnessForPlayer:me withOpponent:you], 14, nil);
    STAssertEquals([game fitnessForPlayer:you withOpponent:me], -14, nil);
}


- (void)testMove {
    Player *me = [[Player alloc] initWithName:@"me"];
    Location *origin = [Location locationWithColumn:0 row:0];
    
    [game performMove:origin forPlayer:me];
    
    STAssertEquals([[board pieceAtLocation:origin] owner], me, nil);
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
    [board setPiece:@"any" atLocation:[Location locationWithColumn:0 row:0]];
    [board addObserver:self];
    
    Location *foo = [Location locationWithColumn:0 row:1];
    [board setPiece:@"any" atLocation:foo];

    Location *bar = [Location locationWithColumn:0 row:2];
    [board setPiece:@"any" atLocation:bar];
    
    STAssertEquals(observed.count, 2u, nil);
    STAssertEqualObjects([observed objectAtIndex:0], foo, nil);
    STAssertEqualObjects([observed objectAtIndex:1], bar, nil);
}

@end
