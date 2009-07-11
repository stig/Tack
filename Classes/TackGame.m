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

#pragma mark Find legal moves

- (NSArray*)legalMovesAtBoard:(Board*)board {
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

- (NSInteger)scoreForPlayer:(Player*)player atLine:(NSArray*)line {
    NSInteger score = 0;
    for (Piece *piece in line) {        
        if (piece.owner != player)
            return 0;
        score *= 10;
        score++;
    }
    return score;
}


- (NSInteger)scoreForPlayer:(Player*)me atBoard:(Board*)board {

    NSMutableArray *lines = [[NSMutableArray alloc] initWithCapacity:8];
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
        
        [lines addObject:horisontal];
        [lines addObject:vertical];
        [horisontal release];
        [vertical release];
    }
    [lines addObject:diagonal1];
    [lines addObject:diagonal2];
    [diagonal1 release];
    [diagonal2 release];
    
    NSInteger score = 0;
    for (NSArray *line in lines)
        score += [self scoreForPlayer:me atLine:line];
    
    [lines release];
    return score;
}

- (NSInteger)fitnessForPlayer:(Player*)me withOpponent:(Player*)you atBoard:(Board*)board {
    return [self scoreForPlayer:me atBoard:board] - [self scoreForPlayer:you atBoard:board];
}

@end
