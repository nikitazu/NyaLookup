//
//  NSArray+JSON.h
//  NyaLookup
//
//  Created by Никита Б. Зуев on 19.02.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Rest.h"

@interface NSArray (JSON)

+ (NSArray*) jsonArrayWithUrl: (NSString*)url;

- (NSData*) toJSON;

@end
