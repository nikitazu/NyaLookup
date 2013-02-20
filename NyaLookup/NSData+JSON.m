//
//  NSData+JSON.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 20.02.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "NSData+JSON.h"

@implementation NSData (JSON)

- (id) json
{
    __autoreleasing NSError* error = nil;
    
    id result = [NSJSONSerialization JSONObjectWithData:self
                                                options:kNilOptions error:&error];
    if (error != nil) { return nil; }
    return result;
}

@end
