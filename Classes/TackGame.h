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
    NSArray *players;
    NSUInteger playerIndex;
    Board *board;
}

@property(readonly,copy) NSArray *players;
@property(readonly,retain) Board *board;

- (id)initWithPlayerOne:(Player*)one two:(Player*)two;

- (Player*)player;
- (Player*)opponent;

- (NSArray*)legalMoves;
- (NSInteger)fitness;
- (void)performMove:(id)move;

@end
