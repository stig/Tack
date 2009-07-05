//
//  Player.h
//  Tick
//
//  Created by Stig Brautaset on 05/07/2009.
//  Copyright 2009 Morgan Stanley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@class Piece;

@interface Player : NSObject <NSCopying> {
    NSString *name;
    NSMutableSet *pieces;
    CGColorRef colour;
}

@property(copy) NSString *name;
@property(retain) NSMutableSet *pieces;
@property(assign) CGColorRef colour;

- (id)initWithName:(NSString*)name;

@end
