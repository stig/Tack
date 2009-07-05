//
//  Board.m
//  TicTacToe
//
//  Created by Stig Brautaset on 13/04/2009.
//  Copyright 2009 Stig Brautaset. All rights reserved.
//

#import "Board.h"
#import "Location.h"

@implementation Board

- (id)initWithColumns:(NSUInteger)columns rows:(NSUInteger)rows {
    self = [super init];
    if (self) {     
        grid = [[NSMutableArray alloc] initWithCapacity: columns];
        
        id null = [NSNull null];
        for (int i = 0; i < columns; i++) {
            NSMutableArray *row = [[NSMutableArray alloc] initWithCapacity:rows];
			
            for (int j = 0; j < rows; j++)
                [row addObject:null];

            [grid addObject:row];
			[row release];
        }
    }
    return self;
}

- (id)init {
    return [self initWithColumns:3 rows:3];
}

- (void)dealloc {
    [grid release];
    [super dealloc];
}

- (NSString*)description {
    return [grid description];
}

#pragma mark -

- (id)pieceAtIndexPath:(Location*)loc {
    return [self pieceAtColumn:[loc column]
                           row:[loc row]];
        
}

- (void)setPiece:(id)piece atIndexPath:(Location*)loc {
    [self setPiece:piece
          atColumn:[loc column]
               row:[loc row]];
   
}

- (id)pieceAtColumn:(NSUInteger)c row:(NSUInteger)r {
    id piece = [[grid objectAtIndex:c] objectAtIndex:r];
	return piece == [NSNull null] ? nil : piece;
}

- (void)setPiece:(id)piece atColumn:(NSUInteger)c row:(NSUInteger)r {
    [[grid objectAtIndex:c] replaceObjectAtIndex:r withObject:piece];
}

- (NSUInteger)columns {
    return [grid count];
}

- (NSUInteger)rows {
    return [[grid lastObject] count];
}

@end
