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
#import "Grid.h"

#import <QuartzCore/QuartzCore.h>

@interface TackViewController ()

- (Player*)currentPlayer;
- (void)togglePlayer;
- (void)makeAiMove;
- (void)moveToColumn:(NSUInteger)c row:(NSUInteger)r;

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
    [self.grid refreshBoardView];
    
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
    self.grid.model = board;

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
            Piece *piece = [board pieceAtColumn:c row:r];
            if (!piece) {
                [self moveToColumn:c row:r];
                return;
            }
        }
    }    
}

- (void)moveToColumn:(NSUInteger)c row:(NSUInteger)r {
    NSLog(@"%@ moving to <%d,%d>", [[players objectAtIndex:currentPlayer] name], c, r);
    
    Piece *piece = [board pieceAtColumn:c row:r];
    if (piece) {
        NSLog(@"Bonk! Cell already occupied.");
        return;
    }

    piece = [Piece new];
    piece.owner = [self currentPlayer];
    [board setPiece:piece atColumn:c row:r];
    
    [self togglePlayer];
}



- (void)clickInColumn:(NSUInteger)c row:(NSUInteger)r {
    if (currentPlayer == aiPlayer) {
        NSLog(@"Sorry, it is %@'s turn", [[self currentPlayer] name]);
        return;
    }
    [self moveToColumn:c row:r];
}


@end
