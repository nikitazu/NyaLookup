//
//  NSArray+JSON.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 19.02.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "NSArray+JSON.h"

@implementation NSArray (JSON)

+ (NSArray*) jsonArrayWithUrl: (NSString*)url
{
    NSData* data = [url curl];
    
    __autoreleasing NSError* error = nil;
    
    id result = [NSJSONSerialization JSONObjectWithData:data
                                                options:kNilOptions error:&error];
    if (error != nil) { return nil; }
    return result;
}

- (NSData*) toJSON
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;    
}

@end
