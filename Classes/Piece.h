//
//  Piece.h
//  Tick
//
//  Created by Stig Brautaset on 05/07/2009.
//  Copyright 2009 Morgan Stanley. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Player;
@class Location;

@interface Piece : NSObject <NSCopying> {
    Player *owner;
    Location *location;
}

@property(copy) Location *location;
@property(retain) Player *owner;

@end
