//
//  TackViewController.m
//  Tack
//
//  Created by Stig Brautaset on 05/07/2009.
//  Copyright Morgan Stanley 2009. All rights reserved.
//

#import "TackViewController.h"
#import "Player.h"
#import "Board.h"
#import "Grid.h"

#import <QuartzCore/QuartzCore.h>

@interface TackViewController ()

- (Player*)currentPlayer;
- (CGColorRef)red;
- (CGColorRef)blue;
- (CALayer*)playerPiece;
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
    one.colour = [self red];
    
    Player *two = [[Player alloc] initWithName:@"Jill"];
    two.colour = [self blue];
    
    players = [[NSArray alloc] initWithObjects:one, two, nil];
    currentPlayer = 0;
    aiPlayer = 1;
    
    self.board = [[Board alloc] initWithColumns:3 rows:3];

    self.grid.controller = self;
    self.grid.board = self.board;    
    [self.grid createGrid];
    
    self.turn.text = [NSString stringWithFormat:@"Waiting for %@ to begin..", one.name];    
}

- (void)dealloc {
    [board release];
    [grid release];
    [turn release];
    [super dealloc];
}

#pragma mark -

- (CGColorRef)red {
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGFloat rgba[] = { 0.7, 0.0, 0.0, 1.0 };
    return CGColorCreate(space, rgba);
}    

- (CGColorRef)blue {
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGFloat rgba[] = { 0.0, 0.0, 0.7, 1.0 };
    return CGColorCreate(space, rgba);
}

- (Player*)currentPlayer {
    return [players objectAtIndex:currentPlayer];
}

- (CALayer*)playerPiece {
    Player *player = [self currentPlayer];
    
    CALayer *piece = [CALayer layer];
    piece.name = player.name;
    piece.backgroundColor = player.colour;
    
    return piece;
}

- (void)togglePlayer {
    currentPlayer = !currentPlayer;
    
    NSString *s = [[players objectAtIndex:currentPlayer] name];

    if (currentPlayer == aiPlayer) {
        s = [NSString stringWithFormat:@"Waiting for %@ to move...", s];
        [self performSelector: @selector(makeAiMove) withObject: nil afterDelay: 1.0f];
        
    } else {
        s = [NSString stringWithFormat:@"%@ searching for a move...", s];
    }
    self.turn.text = s;    
}


- (void)makeAiMove {    
    for (int c = 0; c < self.board.columns; c++) {
        for (int r = 0; r < self.board.rows; r++) {
            CALayer *cell = [self.board pieceAtColumn:c row:r];
            assert(cell && "no cell at board location!");
            
            CALayer *piece = [cell.sublayers lastObject];
            if (!piece) {
                [self moveToColumn:c row:r];
                return;
            }
        }
    }    
}

- (void)moveToColumn:(NSUInteger)c row:(NSUInteger)r {
    NSLog(@"%@ moving to <%d,%d>", [[players objectAtIndex:currentPlayer] name], c, r);
    
    CALayer *cell = [self.board pieceAtColumn:c row:r];
    assert(cell && "no cell at board location");
    
    CALayer *piece = [cell.sublayers lastObject];
    if (piece) {
        NSLog(@"Bonk! Cell already occupied.");
        return;
    }
    
    piece = [self playerPiece];
    piece.frame = CGRectInset(cell.bounds, 8, 8);
    
    [cell addSublayer:piece];
    
    [self togglePlayer];
}



- (void)clickInColumn:(NSUInteger)c row:(NSUInteger)r {
    NSLog(@"%s", _cmd);
    if (currentPlayer == aiPlayer) {
        NSLog(@"Sorry, it is %@'s turn", [players objectAtIndex:aiPlayer]);
        return;
    }
    [self moveToColumn:c row:r];
}


@end
