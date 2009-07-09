//
//  BoardTest.m
//  Tack
//
//  Created by Stig Brautaset on 05/07/2009.
//  Copyright 2009 Stig Brautaset. All rights reserved.
//

#import "BoardTest.h"
#import "Board.h"

@implementation BoardTest

- (void)testEquals {
    Board *one = [[Board alloc] initWithColumns:3 rows:3];
    Board *two = [[Board alloc] initWithColumns:3 rows:3];
    STAssertEqualObjects(one, two, nil);
}
 
- (void)testCopy {
    Board *one = [[Board alloc] initWithColumns:3 rows:3];
    Board *two = [one copy];
    STAssertEqualObjects(one, two, nil);
    
    [one setPiece:@"foo" atColumn:0 row:0];
    STAssertEqualObjects([one pieceAtColumn:0 row:0], @"foo", nil);
    STAssertNil([two pieceAtColumn:0 row:0], nil);
}

@end
