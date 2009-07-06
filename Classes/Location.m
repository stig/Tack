//
//  Location.m
//  Tack
//
//  Created by Stig Brautaset on 05/07/2009.
//  Copyright 2009 Morgan Stanley. All rights reserved.
//

#import "Location.h"


@implementation Location

- (id)initWithColumn:(NSUInteger)c row:(NSUInteger)r {
    self = [super init];
    if (self) {
        NSUInteger indices[] = {c, r};
        indexPath = [[NSIndexPath alloc] initWithIndexes:indices length:2];
    }
    return self;
}

- (id)init {
    NSAssert(0, @"You should call -initWithColumn:row: rather than -init");
    return nil;
}

- (NSUInteger)column {
    return [indexPath indexAtPosition:0];
}

- (NSUInteger)row {
    return [indexPath indexAtPosition:1];
}

- (id)copyWithZone:(NSZone*)zone {
   return [[[self class] alloc] initWithColumn:[self column]
                                           row:[self row]];
}

#pragma mark description

- (NSString*)description {
    return [NSString stringWithFormat:@"[%u,%u]", self.column, self.row];
}

#pragma mark equality

- (BOOL)isEqual:(id)obj {
    return [obj isMemberOfClass:[self class]]
        && [self column] == [obj column]
        && [self row] == [obj row];
}

- (NSUInteger)hash {
    return [indexPath hash];
}

@end
