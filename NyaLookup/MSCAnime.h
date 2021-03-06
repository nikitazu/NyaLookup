//
//  MSCAnime.h
//  NyaLookup
//
//  Created by Никита Б. Зуев on 18.02.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSCAnime : NSObject

@property NSString* title;
@property NSInteger score;
@property NSString* type;
@property BOOL airing;
@property NSInteger current;
@property NSInteger next;
@property NSInteger max;
@property NSString* link;

@property NSString* status;
@property NSColor* statusColor;
@property NSURL* imageUrl;

- (NSString*) progress;
- (id) initWithDictionary:(NSDictionary*)data;
- (void) updateStatus: (NSArray*)torrents;

@end
