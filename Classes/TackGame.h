//
//  TackController.h
//  Tack
//
//  Created by Stig Brautaset on 09/07/2009.
//  Copyright 2009 Stig Brautaset. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Board;
@class Player;

@interface TackGame : NSObject {
    Board *board;
}

@property(readonly,retain) Board *board;

// - (id)init;

- (NSArray*)legalMoves;
- (NSInteger)fitnessForPlayer:(Player*)p withOpponent:(Player*)o;
- (void)performMove:(id)move forPlayer:(Player*)player;

@end
