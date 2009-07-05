//
//  Piece.h
//  Tick
//
//  Created by Stig Brautaset on 05/07/2009.
//  Copyright 2009 Morgan Stanley. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Player;

@interface Piece : NSObject {
    Player *owner;
    NSIndexPath *location;
}

@property(copy) NSIndexPath *location;
@property(assign) Player *owner;

@end
