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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    Player *one = [[Player alloc] initWithName:@"Jack"];    
    aiPlayer = [[Player alloc] initWithName:@"Jill"];
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

#pragma mark -

- (void)togglePlayer {
    NSString *s = [game.player name];

    if (![aiPlayer isEqual:game.player]) {
        s = [NSString stringWithFormat:@"Waiting for %@ to move...", s];        
    } else {
        s = [NSString stringWithFormat:@"%@ searching for a move...", s];
        [self performSelector: @selector(makeAiMove) withObject: nil afterDelay: 1.0f];
    }
    self.turn.text = s;
}


- (void)makeAiMove {
    [self moveToLocation:[[game legalMoves] lastObject]];
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
        NSLog(@"Sorry, it is %@'s turn", [game.player name]);
        return;
    }
    [self moveToLocation:loc];
}


@end
