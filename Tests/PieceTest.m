//
//  PieceTest.m
//  Tack
//
//  Created by Stig Brautaset on 05/07/2009.
//  Copyright 2009 Stig Brautaset. All rights reserved.
//

#import "PieceTest.h"
#import "Piece.h"
#import "Location.h"

@implementation PieceTest

- (void)testCopy {

    Location *loc = [[Location alloc] initWithColumn:2 row:1];
    Piece *one = [Piece new];
    one.location = loc;
    
    Piece *two = [one copy];
    STAssertNotNil(two, nil);
    STAssertEqualObjects(two.location, loc, nil);

    // check that set of pieces is individual from now on
    one.location = [[Location alloc] initWithColumn:1 row:2];    
    STAssertEqualObjects(two.location, loc, nil);
}

@end
