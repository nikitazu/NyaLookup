//
//  NSDictionary+NSDictionaryJSON.h
//  NyaLookup
//
//  Created by Никита Б. Зуев on 19.02.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NSDictionaryJSON)

+ (NSDictionary*) dictionaryWithJSON: (NSString*)url;

- (NSData*) toJSON;

@end
