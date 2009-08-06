//
//  TackController.m
//  Tack
//
//  Created by Stig Brautaset on 09/07/2009.
//  Copyright 2009 Stig Brautaset. All rights reserved.
//

#import "TackGame.h"
#import "Board.h"
#import "Player.h"
#import "Location.h"
#import "Piece.h"

@implementation TackGame

@synthesize players;
@synthesize board;

- (id)initWithPlayerOne:(Player*)one two:(Player*)two {
    self = [super init];
    if (self) {
        players = [[NSArray alloc] initWithObjects:one, two, nil];
        board = [[Board alloc] initWithColumns:3 rows:3];
    }
    return self;
}

- (Player*)player {
    return [players objectAtIndex:playerIndex];
}

- (Player*)opponent {
    return [players objectAtIndex:!playerIndex];
}

#pragma mark Find legal moves

- (NSArray*)legalMoves {
    NSMutableArray *moves = [NSMutableArray arrayWithCapacity:board.rows * board.columns];
    if ([self isGameOver])
        return moves;
    
    for (int c = 0; c < board.columns; c++) {
        for (int r = 0; r < board.rows; r++) {
            Location *loc = [Location locationWithColumn:c row:r];
            if (![board pieceAtLocation:loc])
                [moves addObject:loc];
        }
    }
    
    return [moves copy];
}

#pragma mark Fitness calculations

static NSInteger scoreForLine(NSInteger line[2])
{
	if (line[0])
		return 0;
	
	NSInteger score = 0;
	for (int i = 0; i < line[1]; i++) {
		score *= 10;
		score++;
	}
	return score;
}

- (NSInteger)scoreForPlayer:(Player*)player {
    NSInteger totalScore = 0;

	NSInteger ld1[2] = {0};
	NSInteger ld2[2] = {0};

    Piece *p;
    for (int c = 0; c < board.columns; c++) {
		NSInteger lh[2] = {0};
		NSInteger lv[2] = {0};

        Location *d1 = [Location locationWithColumn:c row:c];
        if (p = [board pieceAtLocation: d1])
			ld1[[p.owner isEqual:player]]++;
		
        Location *d2 = [Location locationWithColumn:2-c row:c];
        if (p = [board pieceAtLocation: d2])
			ld2[[p.owner isEqual:player]]++;

        for (int r = 0; r < board.rows; r++) {
            Location *h = [Location locationWithColumn:r row:c];        
            if (p = [board pieceAtLocation: h])
				lh[[p.owner isEqual:player]]++;

            Location *v = [Location locationWithColumn:c row:r];
            if (p = [board pieceAtLocation: v])
				lv[[p.owner isEqual:player]]++;
        }

        totalScore += scoreForLine(lh);
        totalScore += scoreForLine(lv);
    }
	totalScore += scoreForLine(ld1);
	totalScore += scoreForLine(ld2);
    return totalScore;
}

- (NSInteger)fitness {
    return [self scoreForPlayer:self.player] - [self scoreForPlayer:self.opponent];
}

#pragma mark Perform & undo moves

- (void)performMove:(Location*)move {
    NSAssert(![board pieceAtLocation:move], @"location already occupied!");
    Piece *p = [Piece new];
    p.owner = self.player;
    [board setPiece:p atLocation:move];
	[p release];
    playerIndex = !playerIndex;
}


- (void)undoMove:(Location*)move {
    NSAssert([board pieceAtLocation:move], @"location not occupied!");
    [board setPiece:[NSNull null] atLocation:move];
    playerIndex = !playerIndex;
}

#pragma mark Done yet?

- (BOOL)isGameOver {
    int free = 0;
    for (int c = 0; c < board.columns; c++)
        for (int r = 0; r < board.rows; r++)
            if (![board pieceAtLocation:[Location locationWithColumn:c row:r]])
                free++;
    return !free || abs([self fitness]) > 50;
}

#pragma mark Game tree search

- (NSInteger)fitnessWithDepth:(NSInteger)ply {
    
    NSArray *moves = [self legalMoves];
    if (ply <= 0 || !moves.count)
        return [self fitness];
    
    NSInteger best = INT_MIN;
    for (Location *m in moves) {
        [self performMove:m];
        NSInteger sc = -[self fitnessWithDepth:ply-1];
        [self undoMove:m];
        if (sc > best)
            best = sc;        
    }
    return best;
    
}

- (Location*)moveFromSearchToDepth:(NSUInteger)ply {
    NSArray *moves = [self legalMoves];

    Location *bestMove = nil;
    NSInteger best = INT_MIN;
    for (Location *m in moves) {
        [self performMove:m];
        NSInteger sc = -[self fitnessWithDepth:ply];
        [self undoMove:m];
                
        if (sc > best) {
            best = sc;
            bestMove = m;
        }
    }
    return bestMove;
}

@end
