//
//  MSCFiltersController.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 12.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "MSCFiltersController.h"

@implementation MSCFiltersController

- (IBAction)pending:(id)sender {
    NSLog(@"filter pending");
    [self updateAnimes:[self.shared.root filterPending]];
}

- (IBAction)watching:(id)sender {
    NSLog(@"filter watching");
    [self updateAnimes:[self.shared.root filterWatching]];
}

- (IBAction)complteted:(id)sender {
    NSLog(@"filter completed");
    [self updateAnimes:[self.shared.root filterCompleted]];
}

- (IBAction)onHold:(id)sender {
    NSLog(@"filter onHold");
    [self updateAnimes:[self.shared.root filterOnHold]];
}

- (IBAction)dropped:(id)sender {
    NSLog(@"filter dropped");
    [self updateAnimes:[self.shared.root filterDropped]];
}

- (void) updateAnimes: (id)animes {
    [self.main setAnimes: animes];
    [self.shared.root updateImagesFor:animes inShared:self.shared];
}

@end
