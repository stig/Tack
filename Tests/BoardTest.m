//
//  BoardTest.m
//  Tack
//
//  Created by Stig Brautaset on 05/07/2009.
//  Copyright 2009 Stig Brautaset. All rights reserved.
//

#import "Board.h"
#import "Location.h"

#import <SenTestingKit/SenTestingKit.h>

@interface BoardTest : SenTestCase
@end

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
    
    STAssertEquals(two.rows, one.rows, nil);
    STAssertEquals(two.columns, one.columns, nil);
}

@end
