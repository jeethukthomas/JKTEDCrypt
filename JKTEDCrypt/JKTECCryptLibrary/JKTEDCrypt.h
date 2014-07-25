//
//  JKTEDCrypt.h
//  JKTEDCrypt
//
//  Created by Jeethu on 25/07/14.
//  Copyright (c) 2014 JKT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKTEDCrypt : NSObject
-(NSData*)encrypt:(NSData*)data;
-(NSData*)decrypt:(NSData*)data;
@end
