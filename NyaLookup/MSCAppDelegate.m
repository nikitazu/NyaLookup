//
//  MSCAppDelegate.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 18.02.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "MSCAppDelegate.h"

@implementation MSCAppDelegate

@synthesize animes;
@synthesize animesController;

@synthesize torrents;
@synthesize torrentsController;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.animes = [MSCAnime loadItems];
    
    //MSCAnime* anime = self.animes[1];
    //NSArray*  arr   = [anime findTorrents];
    
    //NSLog(@"%@", arr);
    
    //self.torrents = arr;
}

- (IBAction) searchTorrents:(id) sender
{
    NSLog(@"%@", self.animesController.selectionIndexes);
    MSCAnime* anime = self.animesController.selectedObjects[0];
    NSArray* temp = [anime findTorrents];
    NSLog(@"%@", temp);
    self.torrents = temp;
}

@end
