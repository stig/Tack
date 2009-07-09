//
//  Location.h
//  Tack
//
//  Created by Stig Brautaset on 05/07/2009.
//  Copyright 2009 Stig Brautaset. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Location : NSObject <NSCopying> {
    NSUInteger column, row;
}

@property(readonly) NSUInteger column, row;

+ (id)locationWithColumn:(NSUInteger)c row:(NSUInteger)r;
- (id)initWithColumn:(NSUInteger)c row:(NSUInteger)r;

@end
