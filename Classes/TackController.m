//
//  TackController.m
//  Tack
//
//  Created by Stig Brautaset on 09/07/2009.
//  Copyright 2009 Stig Brautaset. All rights reserved.
//

#import "TackController.h"
#import "Board.h"
#import "Player.h"
#import "Location.h"

@implementation TackController

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

- (NSInteger)fitnessForPlayer:(Player*)me withOpponent:(Player*)you atBoard:(Board*)board {
 
    return 0;
}

@end
