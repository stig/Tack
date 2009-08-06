//
//  Board.m
//  TicTacToe
//
//  Created by Stig Brautaset on 13/04/2009.
//  Copyright 2009 Stig Brautaset. All rights reserved.
//

#import "Board.h"
#import "Location.h"

@interface Board ()
@property(retain) NSMutableDictionary *grid;
@property NSUInteger columns, rows;
@end


@implementation Board

@synthesize columns;
@synthesize rows;
@synthesize grid;

- (id)initWithColumns:(NSUInteger)columns_ rows:(NSUInteger)rows_ {
    self = [super init];
    if (self) {
        columns = columns_;
        rows = rows_;
        grid = [[NSMutableDictionary alloc] initWithCapacity: columns * rows];        
        id null = [NSNull null];
        for (int i = 0; i < columns; i++) {			
            for (int j = 0; j < rows; j++) {
                Location *loc = [Location locationWithColumn:i row:j];
                [grid setObject:null forKey:loc];
            }
        }
    }
    return self;
}

- (id)init {
    return [self initWithColumns:3 rows:3];
}

- (id)copyWithZone:(NSZone*)zone {
    Board *copy = [[Board alloc] init];
    copy.grid = [[NSMutableDictionary alloc] initWithDictionary:self.grid
                                            copyItems:YES];
    copy.columns = self.columns;
    copy.rows = self.rows;
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
    id piece = [grid objectForKey:loc];
	return piece == [NSNull null] ? nil : piece;
}

- (void)setPiece:(id)piece atLocation:(Location*)loc {
    [self willChangeValueForKey:[loc description]];
    [grid setObject:piece forKey:loc];
    [self didChangeValueForKey:[loc description]];
}

#pragma mark Add / remove observers


- (void)addObserver:(id)observer {
    for (id key in grid) {
        NSLog(@"Adding %@ as subscriber to %@ key", observer, [key description]);
        [self addObserver:observer
               forKeyPath:[key description]
                  options:0
                  context:key];
    }
}

- (void)removeObserver:(id)observer {
    for (id key in grid) {
        [self removeObserver:observer
                  forKeyPath:[key description]];
    }
}

@end
