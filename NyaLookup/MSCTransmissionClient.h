//
//  MSCTransmissionClient.h
//  NyaLookup
//
//  Created by Никита Б. Зуев on 03.03.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSCPreferences.h"
#import "NSDictionary+JSON.h"
#import "NSData+JSON.h"

@interface MSCTransmissionClient : NSObject

+ (id)singleton;

@property NSString* sessionID;

- (id) torrentAdd:(NSString*) url;
- (id) send: (NSDictionary*) data;

@end
