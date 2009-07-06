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

@synthesize grid;

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

- (id)copyWithZone:(NSZone*)zone {
    Board *copy = [[Board alloc] init];
    copy.grid = [[NSMutableArray alloc] initWithArray:self.grid
                                            copyItems:YES];
    return copy;
}

- (void)dealloc {
    [grid release];
    [super dealloc];
}

- (NSString*)description {
    return [grid description];
}

#pragma mark Equality

- (BOOL)isEqual:(id)obj {
    return [obj isMemberOfClass:[self class]]
        && [[obj grid] isEqual:self.grid];
    
}

- (NSUInteger)hash {
    return [self.grid hash];
}

#pragma mark Piece access

- (id)pieceAtLocation:(Location*)loc {
    id piece = [[grid objectAtIndex:[loc column]] objectAtIndex:[loc row]];
	return piece == [NSNull null] ? nil : piece;
}

- (void)setPiece:(id)piece atLocation:(Location*)loc {
    [[grid objectAtIndex:[loc column]] replaceObjectAtIndex:[loc row] withObject:piece];   
}

- (id)pieceAtColumn:(NSUInteger)c row:(NSUInteger)r {
    return [self pieceAtLocation:[[Location alloc] initWithColumn:c row:r]];
}

- (void)setPiece:(id)piece atColumn:(NSUInteger)c row:(NSUInteger)r {
    [self setPiece:piece atLocation:[[Location alloc] initWithColumn:c row:r]];
}

- (NSUInteger)columns {
    return [grid count];
}

- (NSUInteger)rows {
    return [[grid lastObject] count];
}

@end
