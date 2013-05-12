//
//  MSCFiltersController.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 12.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "MSCFiltersController.h"

@implementation MSCFiltersController

@synthesize shared;

- (IBAction)pending:(id)sender {
    NSLog(@"filter pending");
    
    NSMutableArray* result = [NSMutableArray array];
    for (Anime* anime in shared.root.animes) {
        if (anime.watches.count == 0) {
            //NSLog(@"anime: %@", anime.title);
            [result addObject:anime];
        }
    }
    
    [self updateAnimes:result];
}

- (IBAction)watching:(id)sender {
    NSLog(@"filter watching");
    
    NSMutableArray* result = [NSMutableArray array];
    for (Anime* anime in shared.root.animes) {
        if (anime.isWatching) {
            //NSLog(@"anime: %@", anime.title);
            [result addObject:anime];
        }
    }
    
    [self updateAnimes:result];
}

- (IBAction)complteted:(id)sender {
    NSLog(@"filter completed");
    
    NSMutableArray* result = [NSMutableArray array];
    for (Anime* anime in shared.root.animes) {
        if (anime.isCompleted) {
            //NSLog(@"anime: %@", anime.title);
            [result addObject:anime];
        }
    }
    
    [self updateAnimes:result];
}

- (IBAction)onHold:(id)sender {
    NSLog(@"filter onHold");
    
    NSMutableArray* result = [NSMutableArray array];
    for (Anime* anime in shared.root.animes) {
        if (anime.isOnHold) {
            //NSLog(@"anime: %@", anime.title);
            [result addObject:anime];
        }
    }
    
    [self updateAnimes:result];
}

- (IBAction)dropped:(id)sender {
    NSLog(@"filter dropped");
    
    NSMutableArray* result = [NSMutableArray array];
    for (Anime* anime in shared.root.animes) {
        if (anime.isDropped) {
            //NSLog(@"anime: %@", anime.title);
            [result addObject:anime];
        }
    }
    
    [self updateAnimes:result];
}

// TODO: fix this mess
- (void) updateAnimes: (id)animes {
    [[NSApp delegate] setAnimes: animes];
}

@end
