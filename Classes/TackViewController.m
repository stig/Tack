//
//  TackViewController.m
//  Tack
//
//  Created by Stig Brautaset on 05/07/2009.
//  Copyright Stig Brautaset 2009. All rights reserved.
//

#import "TackViewController.h"
#import "Player.h"
#import "TackGame.h"
#import "Board.h"
#import "Piece.h"
#import "BoardView.h"
#import "Location.h"

#import <QuartzCore/QuartzCore.h>

@interface TackViewController ()

- (void)togglePlayer;
- (void)makeAiMove;
- (void)moveToLocation:(Location*)loc;

@end

@implementation TackViewController

@synthesize game;
@synthesize grid;
@synthesize turn;

#pragma mark Setup

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Player *one = [[Player alloc] initWithName:@"Hooman"];    
    aiPlayer = [[Player alloc] initWithName:@"Pooter"];
    game = [[TackGame alloc] initWithPlayerOne:one two:aiPlayer];

    self.grid.controller = self;
    self.grid.model = game.board;
    [self.grid createCells];
    
    self.turn.text = [NSString stringWithFormat:@"Waiting for %@ to begin..", one.name];
}

- (void)dealloc {
    [game release];
    [grid release];
    [turn release];
    [super dealloc];
}

#pragma mark Gameplay

- (void)togglePlayer {
    if ([game isGameOver]) {
        NSInteger fitness = [game fitness];
        if (fitness > 0)
            self.turn.text = [NSString stringWithFormat:@"%@ is the winner!", game.player.name];
        else if (fitness < 0)
            self.turn.text = [NSString stringWithFormat:@"%@ is the winner!", game.opponent.name];
        else
            self.turn.text = @"You managed a draw!";
        
        return;
    }

    if (![aiPlayer isEqual:game.player]) {
        self.turn.text = [NSString stringWithFormat:@"Waiting for %@ to move...", game.player.name];
    } else {
        self.turn.text = [NSString stringWithFormat:@"%@ searching for a move...", game.player.name];
        [self performSelector: @selector(makeAiMove) withObject: nil afterDelay: 1.0f];
    }
}


- (void)makeAiMove {
    [self moveToLocation:[game moveFromSearchToDepth:3]];
}

- (void)moveToLocation:(Location*)loc {
    
    Piece *piece = [game.board pieceAtLocation:loc];
    if (piece) {
        NSLog(@"Bonk! Cell already occupied.");
        return;
    }

    [game performMove:loc];    
    [self togglePlayer];
}

- (void)clickAtLocation:(Location*)loc {
    if ([aiPlayer isEqual:game.player]) {
        self.turn.text = [NSString stringWithFormat:@"Sorry, it is %@'s turn", game.player.name];
        return;
    } else if ([game isGameOver]) {
        self.turn.text = @"No move possible: it is Game Over I am afraid!";
        return;
    }
    [self moveToLocation:loc];
}


@end
