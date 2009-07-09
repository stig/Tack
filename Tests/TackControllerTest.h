//
//  TackControllerTest.h
//  Tack
//
//  Created by Stig Brautaset on 09/07/2009.
//  Copyright 2009 Stig Brautaset. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@class Board;
@class TackController;

@interface TackControllerTest : SenTestCase {
    Board *board;
    TackController *game;
}
@end
