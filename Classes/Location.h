//
//  Location.h
//  Tack
//
//  Created by Stig Brautaset on 05/07/2009.
//  Copyright 2009 Morgan Stanley. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Location : NSObject <NSCopying> {
    NSIndexPath *indexPath;
}

- (id)initWithColumn:(NSUInteger)c row:(NSUInteger)r;

- (NSUInteger)column;
- (NSUInteger)row;

@end
