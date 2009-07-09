//
//  TackController.h
//  Tack
//
//  Created by Stig Brautaset on 09/07/2009.
//  Copyright 2009 Stig Brautaset. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Board;
@class Player;

@interface TackGame : NSObject {
}

- (NSArray*)legalMovesAtBoard:(Board*)board;
- (NSInteger)fitnessForPlayer:(Player*)p withOpponent:(Player*)o atBoard:(Board*)b;

@end
