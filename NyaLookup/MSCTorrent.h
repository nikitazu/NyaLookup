//
//  MSCTorrent.h
//  NyaLookup
//
//  Created by Никита Б. Зуев on 18.02.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSArray+JSON.h"
#import "NSString+Rest.h"

@interface MSCTorrent : NSObject

@property NSString* title;
@property NSString* category;
@property NSString* link;
@property NSString* seed;
@property NSString* leech;
@property NSString* down;
@property NSString* description;

- (NSString*) peers;

- (id) initWithDictionary:(NSDictionary*)data;

+ (NSArray*) query:(NSString*)terms;

@end
