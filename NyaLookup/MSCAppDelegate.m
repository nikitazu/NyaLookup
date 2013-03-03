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
    self.preferences = [MSCPreferences preferences];
    _ruby            = [MSCRuby client:self.preferences];
    _transmission    = [MSCTransmissionClient client:self.preferences];
    self.animes      = [_ruby indexAnime];
    
    
    [self updateStatusWithTimer: nil];
    _statusTimer = [NSTimer scheduledTimerWithTimeInterval:60
                                                    target:self
                                                  selector:@selector(updateStatusWithTimer:)
                                                  userInfo:nil
                                                   repeats:YES];
}

- (void) updateStatusWithTimer: (NSTimer*)timer {
    NSInteger hits = 0;
    
    for (MSCAnime* anime in self.animes) {
        NSArray* aTorrents = [_ruby searchTorrentsForAnime:anime];
        [anime updateStatus: aTorrents];
        
        if (aTorrents.count > 0) { hits += 1; }
    }
    
    NSDockTile *tile = [[NSApplication sharedApplication] dockTile];
    
    if (hits > 0) {
        [tile setBadgeLabel:[NSString stringWithFormat:@"%ld", hits]];
    } else {
        [tile setBadgeLabel:nil];
    }
}

- (IBAction) searchTorrents:(id)sender
{
    self.torrents = [_ruby searchTorrentsForAnime:[self anime]];
}

- (IBAction) getTorrent:(id)sender
{
    [self writeToPasteBoard:[[self torrent] link]];
    [_transmission torrentAdd:[[self torrent] link]];
}

- (IBAction) queryTorrent:(id)sender
{
    self.torrents = [_ruby searchTorrents: self.torrentQuery.stringValue];
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
