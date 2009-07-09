//
//  Player.h
//  Tick
//
//  Created by Stig Brautaset on 05/07/2009.
//  Copyright 2009 Stig Brautaset. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@class Piece;

@interface Player : NSObject <NSCopying> {
    NSString *name;
    NSMutableSet *pieces;
}

@property(copy) NSString *name;
@property(retain) NSMutableSet *pieces;

- (id)initWithName:(NSString*)name;

@end
