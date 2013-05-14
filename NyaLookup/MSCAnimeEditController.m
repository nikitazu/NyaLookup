//
//  MSCAnimeSetSearchNameController.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 12.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "MSCAnimeEditController.h"

@implementation MSCAnimeEditController

@synthesize main;
@synthesize shared;
//@synthesize anime;

- (IBAction)showWindow:(id)sender {
    //anime = animeController.content;
        NSLog(@"shared=%@", shared);
    main = [NSApp delegate];
    windowController = [[NSWindowController alloc]
                        initWithWindowNibName:@"AnimeEditWindow"
                                        owner:self];
        NSLog(@"shared=%@", shared);
    
    [windowController showWindow:nil];
    
    NSRect pos = [masterWindow frame];
    NSRect old = [window frame];
    
    // center owner
    old.origin.x = pos.origin.x + (pos.size.width / 2) - (old.size.width / 2);
    old.origin.y = pos.origin.y + (pos.size.height / 2) - (old.size.height / 2);
    
    [window setFrame:old display:YES];
    [window makeKeyAndOrderFront:nil];
        NSLog(@"shared=%@", shared);
}

// FIXME: save failing without error
- (IBAction)okClick:(id)sender {
    //NSLog(@"anime title is %@", anime.title);
    
    //NSError* errorGet;
    //id editAnime = [shared.context existingObjectWithID:anime.objectID error:&errorGet];
    //NSLog(@"err get %@", errorGet);
    //[editAnime setTitle: anime.title];
    
    //NSLog(@"id: %@, edit: %@", anime.objectID, [editAnime title]);
    
    //Anime* currentAnime = animeController.content;
    //currentAnime.title = [NSString stringWithFormat:@"%@q", currentAnime.title];
    NSLog(@"shared=%@", shared);
    NSError* error;
    if ([shared.context save:&error] == NO) {
        NSLog(@"ERROR: anime edit failed - %@, %@", error, error.userInfo);
    }
    [window close];
    [windowController close];
    window = nil;
    windowController = nil;
}

- (IBAction)cancelClick:(id)sender {
    [window close];
    [windowController close];
    window = nil;
    windowController = nil;
}

@end
