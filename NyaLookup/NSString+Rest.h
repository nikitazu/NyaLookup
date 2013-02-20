//
//  NSString+Rest.h
//  NyaLookup
//
//  Created by Никита Б. Зуев on 20.02.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSData+JSON.h"

@interface NSString (Rest)

- (NSData*) curl;
- (id) curlJson;
- (NSString*) quote;
- (NSString*) get: (NSString*)method;
- (NSString*) get: (NSString*)method withData:(NSString*)data;

@end
