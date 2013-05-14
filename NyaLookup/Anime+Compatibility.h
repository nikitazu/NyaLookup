//
//  Anime+Compatibility.h
//  NyaLookup
//
//  Created by Никита Б. Зуев on 12.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "Anime.h"
#import "Watch.h"
#import "MSCAnime.h"

@interface Anime (Compatibility)

- (void) initWithAnime: (MSCAnime*)anime;

- (NSInteger) next;
- (NSInteger) current;

- (NSString*) progress;
- (void) updateStatus: (NSArray*)torrents;

- (bool)isPending;
- (bool)isWatching;
- (bool)isCompleted;
- (bool)isOnHold;
- (bool)isDropped;

@end
