//
//  NSString+Rest.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 20.02.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "NSString+Rest.h"

@implementation NSString (Rest)

- (NSData*) curl
{
    NSURL*  aurl = [NSURL URLWithString:self];
    NSData* data = [NSData dataWithContentsOfURL:aurl];
    return data;
}

- (NSString*) quote
{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@"+"];
}

@end
