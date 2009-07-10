//
//  TackViewController.m
//  Tack
//
//  Created by Stig Brautaset on 05/07/2009.
//  Copyright Stig Brautaset 2009. All rights reserved.
//

#import "TackViewController.h"
#import "Player.h"
#import "Board.h"
#import "Piece.h"
#import "BoardView.h"
#import "Location.h"

#import <QuartzCore/QuartzCore.h>

@interface TackViewController ()

- (Player*)currentPlayer;
- (void)togglePlayer;
- (void)makeAiMove;
- (void)moveToLocation:(Location*)loc;

@end

@implementation TackViewController

@synthesize grid;
@synthesize board;
@synthesize turn;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    Player *one = [[Player alloc] initWithName:@"Jack"];    
    Player *two = [[Player alloc] initWithName:@"Jill"];
    
    players = [[NSArray alloc] initWithObjects:one, two, nil];
    currentPlayer = 0;
    aiPlayer = 1;
    
    self.board = [[Board alloc] initWithColumns:3 rows:3];

    self.grid.controller = self;
    self.grid.model = self.board;    
    [self.grid createCells];
    
    self.turn.text = [NSString stringWithFormat:@"Waiting for %@ to begin..", one.name];    
}

- (void)dealloc {
    [board release];
    [grid release];
    [turn release];
    [super dealloc];
}

#pragma mark -

- (Player*)currentPlayer {
    return [players objectAtIndex:currentPlayer];
}

- (void)togglePlayer {
    currentPlayer = !currentPlayer;
    NSString *s = [[self currentPlayer] name];

    if (currentPlayer != aiPlayer) {
        s = [NSString stringWithFormat:@"Waiting for %@ to move...", s];        
    } else {
        s = [NSString stringWithFormat:@"%@ searching for a move...", s];
        [self performSelector: @selector(makeAiMove) withObject: nil afterDelay: 1.0f];
    }
    self.turn.text = s;
}


- (void)makeAiMove {    
    for (int c = 0; c < board.columns; c++) {
        for (int r = 0; r < board.rows; r++) {
            Location *loc = [Location locationWithColumn:c row:r];
            Piece *piece = [board pieceAtLocation:loc];
            if (!piece) {
                [self moveToLocation:loc];
                return;
            }
        }
    }    
}

- (void)moveToLocation:(Location*)loc {
    
    Piece *piece = [board pieceAtLocation:loc];
    if (piece) {
        NSLog(@"Bonk! Cell already occupied.");
        return;
    }

    piece = [Piece new];
    piece.owner = [self currentPlayer];
    [board setPiece:piece atLocation:loc];
    
    [self togglePlayer];
}

- (void)clickAtLocation:(Location*)loc {
    if (currentPlayer == aiPlayer) {
        NSLog(@"Sorry, it is %@'s turn", [[self currentPlayer] name]);
        return;
    }
    [self moveToLocation:loc];
}


@end
