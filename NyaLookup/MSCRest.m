//
//  MSCRest.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 19.02.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "MSCRest.h"

@implementation MSCRest

+ (NSData*) curl: (NSString*)url
{
    NSURL*  aurl = [NSURL URLWithString:url];
    NSData* data = [NSData dataWithContentsOfURL:aurl];
    return data;
}

@end
