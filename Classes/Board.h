//
//  Board.h
//  TicTacToe
//
//  Created by Stig Brautaset on 13/04/2009.
//  Copyright 2009 Stig Brautaset. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Board : NSObject {
    NSMutableArray *grid;
}

@property (readonly) NSUInteger rows, columns;

- (id)initWithColumns:(NSUInteger)x rows:(NSUInteger)y;

- (id)pieceAtIndexPath:(NSIndexPath*)indexPath;
- (void)setPiece:(id)piece atIndexPath:(NSIndexPath*)indexPath;

- (id)pieceAtColumn:(NSUInteger)c row:(NSUInteger)r;
- (void)setPiece:(id)piece atColumn:(NSUInteger)c row:(NSUInteger)r;

@end
