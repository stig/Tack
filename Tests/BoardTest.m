//
//  BoardTest.m
//  Tack
//
//  Created by Stig Brautaset on 05/07/2009.
//  Copyright 2009 Stig Brautaset. All rights reserved.
//

#import "BoardTest.h"
#import "Board.h"
#import "Location.h"

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
    
    Location *origin = [Location locationWithColumn:0 row:0];
    [one setPiece:@"foo" atLocation:origin];
    STAssertEqualObjects([one pieceAtLocation:origin], @"foo", nil);
    STAssertNil([two pieceAtLocation:origin], nil);
}

@end
