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
}

- (IBAction) searchTorrents:(id)sender
{
    self.torrents = [[self anime] findTorrents];
}

- (IBAction) getTorrent:(id)sender
{
//    NSLog(@"getTorrent: %@", [[self torrent] title]);
    if ([self writeToPasteBoard:[[self torrent] link]] == YES) {
        NSLog(@"link copied to clipboard");
    }
}

- (IBAction) queryTorrent:(id)sender
{
    self.torrents = [MSCTorrent query: self.torrentQuery.stringValue];
}

- (MSCAnime*) anime
{
    return self.animesController.selectedObjects[0];
}

- (MSCTorrent*) torrent
{
    return self.torrentsController.selectedObjects[0];
}

- (BOOL) writeToPasteBoard:(NSString *)stringToWrite
{
    NSPasteboard *pasteBoard = [NSPasteboard generalPasteboard];
    [pasteBoard clearContents];
    return [pasteBoard writeObjects:[NSArray arrayWithObject:stringToWrite]];
}

@end
