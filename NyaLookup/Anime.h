//
//  Anime.h
//  NyaLookup
//
//  Created by Никита Б. Зуев on 12.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "MSCAnime.h"

@class Root;

@interface Anime : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * score;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSNumber * airing;
@property (nonatomic, retain) NSNumber * series;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * imageUrl;
@property (nonatomic, retain) Root *root;

- (void) initWithAnime: (MSCAnime*)anime;

// msc compatibility
- (NSInteger) next;
- (NSInteger) current;

@property NSString* status;
@property NSColor* statusColor;
@property NSURL* imageNSURL;

- (NSString*) progress;
//- (id) initWithDictionary:(NSDictionary*)data;
- (void) updateStatus: (NSArray*)torrents;

@end
