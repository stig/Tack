//
//  TackViewController.h
//  Tack
//
//  Created by Stig Brautaset on 05/07/2009.
//  Copyright Stig Brautaset 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BoardView;
@class Location;
@class TackGame;
@class Player;

@interface TackViewController : UIViewController {
    UILabel *turn;
    Player *aiPlayer;
    
    TackGame *game;
    BoardView *grid;
}

@property (retain) IBOutlet TackGame *game;
@property (retain) IBOutlet BoardView *grid;
@property (retain) IBOutlet UILabel *turn;

- (void)clickAtLocation:(Location*)loc;

@end

