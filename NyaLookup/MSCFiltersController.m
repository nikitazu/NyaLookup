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
    [self updateAnimes:[shared.root filterPending]];
}

- (IBAction)watching:(id)sender {
    NSLog(@"filter watching");
    [self updateAnimes:[shared.root filterWatching]];
}

- (IBAction)complteted:(id)sender {
    NSLog(@"filter completed");
    [self updateAnimes:[shared.root filterCompleted]];
}

- (IBAction)onHold:(id)sender {
    NSLog(@"filter onHold");
    [self updateAnimes:[shared.root filterOnHold]];
}

- (IBAction)dropped:(id)sender {
    NSLog(@"filter dropped");
    [self updateAnimes:[shared.root filterDropped]];
}

// TODO: fix this mess
- (void) updateAnimes: (id)animes {
    [[NSApp delegate] setAnimes: animes];
}

@end
