//
//  MSCAnimeSetSearchNameController.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 12.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "MSCAnimeEditController.h"

@implementation MSCAnimeEditController

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


@end
