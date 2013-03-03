//
//  NSDictionary+JSON.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 03.03.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "NSDictionary+JSON.h"

@implementation NSDictionary (JSON)

- (NSData*) toJSON
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self
                                                options:kNilOptions
                                                  error:&error];
    if (error != nil) return nil;
    return result;
}

@end
