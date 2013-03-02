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
    //_client          = [MSCClient client: self.preferences];
    self.animes      = [_ruby indexAnime];
}

- (IBAction) searchTorrents:(id)sender
{
    self.torrents = [_ruby searchTorrentsForAnime:[self anime]];
}

- (IBAction) getTorrent:(id)sender
{
    [self writeToPasteBoard:[[self torrent] link]];
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
