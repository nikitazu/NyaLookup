//
//  MSCAppDelegate.h
//  NyaLookup
//
//  Created by Никита Б. Зуев on 18.02.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MSCAnime.h"
#import "MSCRuby.h"
#import "MSCTransmissionClient.h"

@interface MSCAppDelegate : NSObject <NSApplicationDelegate>
{
    MSCRuby*               _ruby;
    MSCTransmissionClient* _transmission;
    NSTimer*               _statusTimer;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTextField *torrentQuery;

@property (retain) NSArray* animes;
@property (assign) IBOutlet NSArrayController* animesController;

@property (retain) NSArray* torrents;
@property (assign) IBOutlet NSArrayController* torrentsController;

@property (retain) MSCPreferences* preferences;

- (IBAction) searchTorrents:(id)sender;
- (IBAction) getTorrent:(id)sender;
- (IBAction) queryTorrent:(id)sender;


@end
