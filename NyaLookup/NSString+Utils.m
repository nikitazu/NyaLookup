//
//  NSString+Utils.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 19.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

- (NSString*) trimmed {
    NSCharacterSet* empty = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:empty];
}

- (BOOL) isEmpty {
    return self == nil || [[self trimmed] isEqualToString:@""];
}

@end
