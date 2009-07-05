//
//  NSIndexPath+Board.h
//  Tick
//
//  Created by Stig Brautaset on 05/07/2009.
//  Copyright 2009 Morgan Stanley. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSIndexPath (ColumnRow)

+ (id)indexPathWithColumn:(NSUInteger)c row:(NSUInteger)r;

@end
