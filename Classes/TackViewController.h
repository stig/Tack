//
//  TackViewController.h
//  Tack
//
//  Created by Stig Brautaset on 05/07/2009.
//  Copyright Stig Brautaset 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Board;
@class Grid;

@interface TackViewController : UIViewController {
    UILabel *turn;
    NSArray *players;
    NSUInteger currentPlayer, aiPlayer;
    
    Board *board;
    Grid *grid;
}

@property (retain) IBOutlet Board *board;
@property (retain) IBOutlet Grid *grid;
@property (retain) IBOutlet UILabel *turn;

- (void)clickInColumn:(NSUInteger)c row:(NSUInteger)r;

@end

