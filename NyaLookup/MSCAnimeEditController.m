//
//  MSCAnimeSetSearchNameController.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 12.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "MSCAnimeEditController.h"
#import "MSCFiltersController.h"
#import "MSCAppDelegate.h"
#import "MSCShared.h"
#import "Watch.h"

@implementation MSCAnimeEditController

// edit anime
- (IBAction)showWindow:(id)sender {
    if (![self.main anime]) {
        NSLog(@"no anime selected");
        return;
    }
    
    windowController = [[NSWindowController alloc]
                        initWithWindowNibName:@"AnimeEditWindow"
                                        owner:self];
    
    [windowController showWindow:nil];
    
    NSRect pos = [masterWindow frame];
    NSRect old = [window frame];
    
    // center owner
    old.origin.x = pos.origin.x + (pos.size.width / 2) - (old.size.width / 2);
    old.origin.y = pos.origin.y + (pos.size.height / 2) - (old.size.height / 2);
    
    [window setFrame:old display:YES];
    [window makeKeyAndOrderFront:nil];
}

- (IBAction)okClick:(id)sender {
    if (![self.shared saveContex]) {
        NSLog(@"ERROR: anime edit failed");
    }
    [window close];
    [windowController close];
    window = nil;
    windowController = nil;
}

- (IBAction)cancelClick:(id)sender {
    [self.shared.context rollback];
    [window close];
    [windowController close];
    window = nil;
    windowController = nil;
}

// increment/decrement
- (IBAction)incrementSeries:(id)sender {
    if ([[self.main anime] incrementSeries]) {
        [self.shared saveContex];
    }
}

- (IBAction)decrementSeries:(id)sender {
    if ([[self.main anime] decrementSeries]) {
        [self.shared saveContex];
    }
}

// change status
- (IBAction)setPending:(id)sender {
    NSLog(@"setting anime as pending");
    
    Anime* anime = [[self main] anime];
    if (anime == nil) {
        NSLog(@"anime is not selected");
        return;
    }
    
    [anime setPending];
    if ([self.shared saveContex]) {
        NSLog(@"anime %@ moved to pending, watch data cleared", anime.title);
        [[[self main] filtersController] pending:nil];
    }
}

- (IBAction)watch:(id)sender {
    NSLog(@"watching anime");
    Anime* anime = [[self main] anime];
    if (anime == nil) {
        NSLog(@"anime is not selected");
        return;
    }
    
    [anime watch: [self.shared insertEntity:@"Watch"]];
    if ([self.shared saveContex]) {
        NSLog(@"watching anime %@", anime.title);
        [[[self main] filtersController] watching:nil];
        
    }
}

- (IBAction)complete:(id)sender {
    NSLog(@"completed watching anime");
    Anime* anime = [[self main] anime];
    if (anime == nil) {
        NSLog(@"anime is not selected");
        return;
    }
    
    if ([anime complete] && [self.shared saveContex]) {
        NSLog(@"anime %@ was completed", anime.title);
        [[[self main] filtersController] complteted:nil];
        
    }
}

- (IBAction)hold:(id)sender {
    NSLog(@"putting anime on hold");
    Anime* anime = [[self main] anime];
    if (anime == nil) {
        NSLog(@"anime is not selected");
        return;
    }
    
    if ([anime hold] && [self.shared saveContex]) {
        NSLog(@"anime %@ was put on hold", anime.title);
        [[[self main] filtersController] onHold:nil];
        
    }
}

- (IBAction)drop:(id)sender {
    NSLog(@"dropping anime");
    Anime* anime = [[self main] anime];
    if (anime == nil) {
        NSLog(@"anime is not selected");
        return;
    }
    
    if ([anime drop] && [self.shared saveContex]) {
        NSLog(@"anime %@ was dropped", anime.title);
        [[[self main] filtersController] dropped:nil];
    }
}


@end
