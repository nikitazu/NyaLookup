//
//  Root+AnimeFilters.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 12.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "Root+AnimeFilters.h"

@implementation Root (AnimeFilters)

- (NSArray*) filterPending {
    NSMutableArray* result = [NSMutableArray array];
    for (Anime* anime in self.animes) {
        if (anime.isPending) {
            [result addObject:anime];
        }
    }
    return result;
}

- (NSArray*) filterWatching {
    NSMutableArray* result = [NSMutableArray array];
    for (Anime* anime in self.animes) {
        if (anime.isWatching) {
            [result addObject:anime];
        }
    }
    return result;
}

- (NSArray*) filterCompleted {
    NSMutableArray* result = [NSMutableArray array];
    for (Anime* anime in self.animes) {
        if (anime.isCompleted) {
            [result addObject:anime];
        }
    }
    return result;
}

- (NSArray*) filterOnHold {
    NSMutableArray* result = [NSMutableArray array];
    for (Anime* anime in self.animes) {
        if (anime.isOnHold) {
            [result addObject:anime];
        }
    }
    return result;
}

- (NSArray*) filterDropped {
    NSMutableArray* result = [NSMutableArray array];
    for (Anime* anime in self.animes) {
        if (anime.isDropped) {
            [result addObject:anime];
        }
    }
    return result;
}


@end
