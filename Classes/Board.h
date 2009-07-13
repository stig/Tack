//
//  Board.h
//  TicTacToe
//
//  Created by Stig Brautaset on 13/04/2009.
//  Copyright 2009 Stig Brautaset. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Location;

@interface Board : NSObject <NSCopying> {
    NSMutableDictionary *grid;
    NSUInteger rows, columns;
}

@property(readonly) NSUInteger rows, columns;

- (id)initWithColumns:(NSUInteger)x rows:(NSUInteger)y;

- (id)pieceAtLocation:(Location*)loc;
- (void)setPiece:(id)piece atLocation:(Location*)loc;

- (void)addObserver:(id)observer;
- (void)removeObserver:(id)observer;

@end
