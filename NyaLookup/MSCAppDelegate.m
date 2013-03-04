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
    
    [self progressStart];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray* animeArray = [_ruby indexAnime];
        
        if (animeArray != nil) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                self.animes = animeArray;
                [self testConnectionSuccess];
            });
        } else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self testConnectionFail];
            });
        }
    });
}

- (void) progressStart {
    [_progress setHidden:NO];
    [_progress startAnimation:self];
}

- (void) progressStop {
    [_progress stopAnimation:self];
    [_progress setHidden:YES];
}


- (BOOL) testConnectionDo {
    [_ruby indexAnime];
    return YES;
}

- (void) testConnectionSuccess {
    NSLog(@"connection ok");
    [self updateStatusWithTimer: nil];
    [self progressStop];
    _statusTimer = [NSTimer scheduledTimerWithTimeInterval:60*5
                                                    target:self
                                                  selector:@selector(updateStatusWithTimer:)
                                                  userInfo:nil
                                                   repeats:YES];
}

- (void) testConnectionFail {
    NSLog(@"no connection");
    [self progressStop];
}


- (void) updateStatusWithTimer: (NSTimer*)timer {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSInteger hits = 0;
        
        for (MSCAnime* anime in self.animes) {
            NSArray* aTorrents = [_ruby searchTorrentsForAnime:anime];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                [anime updateStatus: aTorrents];
            });
            
            if (aTorrents.count > 0) { hits += 1; }
        }
        
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSDockTile *tile = [[NSApplication sharedApplication] dockTile];
            
            if (hits > 0) {
                [tile setBadgeLabel:[NSString stringWithFormat:@"%ld", hits]];
            } else {
                [tile setBadgeLabel:nil];
            }
        });
    });
}

- (IBAction) searchTorrents:(id)sender
{
    [self progressStart];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray* torrentsArray = [_ruby searchTorrentsForAnime:[self anime]];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.torrents = torrentsArray;
            [self progressStop];
        });
    });
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
