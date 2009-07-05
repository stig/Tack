//
//  NSIndexPath+Board.m
//  Tick
//
//  Created by Stig Brautaset on 05/07/2009.
//  Copyright 2009 Morgan Stanley. All rights reserved.
//

#import "NSIndexPath+ColumnRow.h"


@implementation NSIndexPath (ColumnRow)

+ (id)indexPathWithColumn:(NSUInteger)c row:(NSUInteger)r {
    NSUInteger indices[] = {c, r};
    return [self indexPathWithIndexes:indices length:2];
}

@end
