//
//  MSCAppDelegate.h
//  NyaLookup
//
//  Created by Никита Б. Зуев on 18.02.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

// system
#import <Cocoa/Cocoa.h>
#import <CoreData/CoreData.h>

// controllers
#import "MSCMenuController.h"
#import "MSCFiltersController.h"
#import "MSCAnimeEditController.h"

// core data
#import "Root.h"
#import "Anime.h"
#import "Root+AnimeFilters.h"

// my
#import "MSCAnime.h"
#import "MSCRuby.h"
#import "MSCTransmissionClient.h"
#import "MSCShared.h"

@interface MSCAppDelegate : NSObject <NSApplicationDelegate>
{    
    NSTimer*               _statusTimer;
    
    IBOutlet NSProgressIndicator* _progress;
    
    Root* _root;
}

// controllers
@property (retain) IBOutlet MSCMenuController* menuController;
@property (retain) IBOutlet MSCFiltersController* filtersController;
@property (retain) IBOutlet MSCAnimeEditController* animeEditController;

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTextField *torrentQuery;

@property (retain) NSArray* animes;
@property (assign) IBOutlet NSArrayController* animesController;
- (NSArray*) animesSortDescriptor;

@property (retain) NSArray* torrents;
@property (assign) IBOutlet NSArrayController* torrentsController;

- (IBAction) searchTorrents:(id)sender;
- (IBAction) getTorrent:(id)sender;
- (IBAction) queryTorrent:(id)sender;

// shared state access
@property MSCShared* shared;

@end
