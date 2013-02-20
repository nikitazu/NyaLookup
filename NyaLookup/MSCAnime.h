//
//  MSCAnime.h
//  NyaLookup
//
//  Created by Никита Б. Зуев on 18.02.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSArray+JSON.h"
#import "MSCPreferences.h"
#import "MSCRest.h"
#import "MSCTorrent.h"

@interface MSCAnime : NSObject

@property NSString* title;
@property NSInteger score;
@property NSString* type;
@property BOOL airing;
@property NSInteger current;
@property NSInteger max;

- (NSString*) progress;

+ (NSArray*) loadItems;

- (id) initWithDictionary:(NSDictionary*)data;

- (NSArray*) findTorrents;

@end