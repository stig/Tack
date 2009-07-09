//
//  TackControllerTest.m
//  Tack
//
//  Created by Stig Brautaset on 09/07/2009.
//  Copyright 2009 Stig Brautaset. All rights reserved.
//

#import "TackControllerTest.h"
#import "TackController.h"
#import "Board.h"
#import "Player.h"
#import "Piece.h"
#import "Location.h"

@implementation TackControllerTest

- (void)setUp {
    game = [TackController new];
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
    
}


@end
