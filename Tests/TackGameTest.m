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
    game = [TackGame new];
    board = [[Board alloc] initWithColumns:3 rows:3];
}

- (void)testLegalMoves {
    NSArray *moves;
    STAssertNotNil(moves = [game legalMovesAtBoard:board], nil);
    STAssertEquals(moves.count, 9u, nil);
    
    NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(4, 4)];
    NSArray *taken = [moves objectsAtIndexes:indexes];
    
    for (Location *loc in taken) {
        [board setPiece:@"occupied" atLocation:loc];
    }
    
    STAssertNotNil(moves = [game legalMovesAtBoard:board], nil);
    STAssertEquals(moves.count, 5u, nil);
    
    NSSet *moveSet = [NSSet setWithArray:moves];
    NSSet *takenSet = [NSSet setWithArray:taken];
    STAssertFalse([moveSet intersectsSet:takenSet], nil);
}


- (void)testFitness {
    Player *me = [[Player alloc] initWithName:@"me"];
    Player *you = [[Player alloc] initWithName:@"you"];
    
    STAssertEquals([game fitnessForPlayer:me withOpponent:you atBoard:board], 0, nil);

    Piece *p = [Piece new];
    p.owner = me;
    p.location = [Location locationWithColumn:0 row:0];
    [board setPiece:p atLocation:p.location];
    STAssertEquals([game fitnessForPlayer:me withOpponent:you atBoard:board], 3, nil);
    STAssertEquals([game fitnessForPlayer:you withOpponent:me atBoard:board], -3, nil);

    p = [Piece new];
    p.owner = you;
    p.location = [Location locationWithColumn:0 row:1];
    [board setPiece:p atLocation:p.location];
    STAssertEquals([game fitnessForPlayer:me withOpponent:you atBoard:board], 1, nil);
    STAssertEquals([game fitnessForPlayer:you withOpponent:me atBoard:board], -1, nil);
    
    p = [Piece new];
    p.owner = me;
    p.location = [Location locationWithColumn:1 row:1];
    [board setPiece:p atLocation:p.location];
    STAssertEquals([game fitnessForPlayer:me withOpponent:you atBoard:board], 14, nil);
    STAssertEquals([game fitnessForPlayer:you withOpponent:me atBoard:board], -14, nil);
}


@end