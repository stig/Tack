//
//  TackController.m
//  Tack
//
//  Created by Stig Brautaset on 09/07/2009.
//  Copyright 2009 Stig Brautaset. All rights reserved.
//

#import "TackGame.h"
#import "Board.h"
#import "Player.h"
#import "Location.h"
#import "Piece.h"

@implementation TackGame

@synthesize board;

- (id)init {
    self = [super init];
    if (self) {
        board = [[Board alloc] initWithColumns:3 rows:3];
    }
    return self;
}


#pragma mark Find legal moves

- (NSArray*)legalMoves {
    NSMutableArray *moves = [NSMutableArray arrayWithCapacity:board.rows * board.columns];
    
    for (int c = 0; c < board.columns; c++) {
        for (int r = 0; r < board.rows; r++) {
            Location *loc = [Location locationWithColumn:c row:r];
            if (![board pieceAtLocation:loc])
                [moves addObject:loc];
        }
    }
    
    return [moves copy];
}

#pragma mark Fitness calculations

- (NSInteger)scoreForLines:(NSArray*)lines forPlayer:(Player*)player {
    NSInteger totalScore = 0;
    for (NSArray *line in lines) {
        NSInteger score = 0;
        for (Piece *piece in line) {        
            if (piece.owner != player) {
                score = 0;
                break;
            }
            score *= 10;
            score++;
        }
        totalScore += score;
    }
    return totalScore;
}


- (NSArray*)potentialScoreLines {
    NSMutableArray *lines = [NSMutableArray arrayWithCapacity:8];
    NSMutableArray *diagonal1 = [[NSMutableArray alloc] initWithCapacity:3];
    NSMutableArray *diagonal2 = [[NSMutableArray alloc] initWithCapacity:3];

    Piece *p;
    for (int c = 0; c < board.columns; c++) {
        NSMutableArray *horisontal = [[NSMutableArray alloc] initWithCapacity:3];
        NSMutableArray *vertical = [[NSMutableArray alloc] initWithCapacity:3];

        Location *d1 = [Location locationWithColumn:c row:c];
        if (p = [board pieceAtLocation: d1])
            [diagonal1 addObject: p];

        Location *d2 = [Location locationWithColumn:2-c row:c];
        if (p = [board pieceAtLocation: d2])
            [diagonal2 addObject: p];

        for (int r = 0; r < board.rows; r++) {
            Location *h = [Location locationWithColumn:r row:c];        
            if (p = [board pieceAtLocation: h])
                [horisontal addObject: p];

            Location *v = [Location locationWithColumn:c row:r];
            if (p = [board pieceAtLocation: v])
                [vertical addObject: p];
        }
        
        if (horisontal.count)
            [lines addObject:horisontal];
        if (vertical.count)
            [lines addObject:vertical];
        [horisontal release];
        [vertical release];
    }
    if (diagonal1.count)
        [lines addObject:diagonal1];
    if (diagonal2.count)
        [lines addObject:diagonal2];
    [diagonal1 release];
    [diagonal2 release];
    return lines;
}

- (NSInteger)fitnessForPlayer:(Player*)me withOpponent:(Player*)you {
    NSArray *lines = [self potentialScoreLines];
    return [self scoreForLines:lines forPlayer:me] - [self scoreForLines:lines forPlayer:you];
}

#pragma mark Performing moves

- (void)performMove:(id)move forPlayer:(Player*)player {
    Piece *p = [Piece new];
    p.owner = player;
    [board setPiece:p atLocation:move];
}

@end
