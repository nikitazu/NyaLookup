//
//  Root+AnimeFilters.h
//  NyaLookup
//
//  Created by Никита Б. Зуев on 12.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "Root.h"
#import "Anime+Compatibility.h"

@interface Root (AnimeFilters)

- (NSArray*) filterPending;
- (NSArray*) filterWatching;
- (NSArray*) filterCompleted;
- (NSArray*) filterOnHold;
- (NSArray*) filterDropped;

@end
