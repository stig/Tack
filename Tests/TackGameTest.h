//
//  TackControllerTest.h
//  Tack
//
//  Created by Stig Brautaset on 09/07/2009.
//  Copyright 2009 Stig Brautaset. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@class Board;
@class TackGame;

@interface TackGameTest : SenTestCase {
    Board *board;
    TackGame *game;
}
@end
