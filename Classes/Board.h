//
//  Board.h
//  TicTacToe
//
//  Created by Stig Brautaset on 13/04/2009.
//  Copyright 2009 Stig Brautaset. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Location;

@interface Board : NSObject {
    NSMutableArray *grid;
}

@property (readonly) NSUInteger rows, columns;

- (id)initWithColumns:(NSUInteger)x rows:(NSUInteger)y;

- (id)pieceAtIndexPath:(Location*)loc;
- (void)setPiece:(id)piece atIndexPath:(Location*)loc;

- (id)pieceAtColumn:(NSUInteger)c row:(NSUInteger)r;
- (void)setPiece:(id)piece atColumn:(NSUInteger)c row:(NSUInteger)r;

@end
