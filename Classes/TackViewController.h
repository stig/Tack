//
//  TackViewController.h
//  Tack
//
//  Created by Stig Brautaset on 05/07/2009.
//  Copyright Stig Brautaset 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Board;
@class BoardView;
@class Location;

@interface TackViewController : UIViewController {
    UILabel *turn;
    NSArray *players;
    NSUInteger currentPlayer, aiPlayer;
    
    Board *board;
    BoardView *grid;
}

@property (retain) IBOutlet Board *board;
@property (retain) IBOutlet BoardView *grid;
@property (retain) IBOutlet UILabel *turn;

- (void)clickAtLocation:(Location*)loc;

@end

