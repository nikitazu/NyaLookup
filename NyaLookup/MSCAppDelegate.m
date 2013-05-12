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

@synthesize currentAnime;

// controllers
@synthesize menuController;

// core data access
@synthesize shared;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.preferences = [MSCPreferences preferences];
    
    [self initCoreData];
    [self initRoot];
    
    shared.ruby =           [MSCRuby client:self.preferences];
    shared.transmission =   [MSCTransmissionClient client:self.preferences];
    
    self.menuController.shared = shared;
    
    [self progressStart];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray* animeArray = _root.animes.allObjects;
        
        if (animeArray != nil && animeArray.count > 0) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                NSLog(@"syncronizing initial interface - data");
                self.animes = animeArray;
                self.currentAnime = [self anime];
                [self testConnectionSuccess];
                NSLog(@"syncronizing initial interface - done");
            });
        } else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                NSLog(@"syncronizing initial interface - empty");
                [self testConnectionFail];
            });
        }
    });
}


- (void)initCoreData {
    NSLog(@"initializing core data");
    
    NSManagedObjectContext*         context;
    NSManagedObjectModel*           model;
    NSPersistentStoreCoordinator*   store;
    
    model = [NSManagedObjectModel mergedModelFromBundles:nil];
    store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    NSURL* url = [NSURL fileURLWithPath:@"/Users/nikitazu/NyaLookup.sqlite"];
    NSError* error;
    if (![store addPersistentStoreWithType:NSSQLiteStoreType
                             configuration:nil
                                       URL:url
                                   options:nil
                                     error:&error]) {
        [self logError:error inMethod:@"initCoreData"];
        abort();
    }
    
    NSLog(@"initializing managed object context");
    context = [[NSManagedObjectContext alloc] init];
    [context setPersistentStoreCoordinator:store];
    
    shared = [[MSCShared alloc] initWithContext:context
                                       andModel:model
                                       andStore:store];
    
    NSLog(@"initializing core data completed");
}

- (void) initRoot {
    NSLog(@"initializing root");
    
    NSError* error;
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* desc = [shared entityDescription:@"Root"];
    
    [request setEntity:desc];
    
    NSArray* results = [shared.context executeFetchRequest:request error:&error];
    if (results == nil) {
        [self logError:error inMethod:@"initRoot/fetch"];
    }
    
    NSLog(@"object storage contains %ld root objects", results.count);
    
    if (results.count == 0) {
        NSLog(@"initializing root object");
        
        _root = [shared insertEntity:@"Root"];
        _root.v = @1;
        
        NSLog(@"root object initialized: %@", _root);
        
        if ([shared.context save:&error] == YES) {
            NSLog(@"root object persisted");
        } else {
            [self logError:error inMethod:@"initRoot/save"];
        }
    } else {
        for(Root* root in results) {
            _root = root;
            break;
        }
    }
    
    shared.root = _root;
    
    NSLog(@"root object found: %@, %@", _root, _root.v);
    NSLog(@"initializing root completed");
}

- (Anime*) insertAnime {
    return [shared insertEntity:@"Anime"];
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
    [shared.ruby indexAnime];
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
    [self updateAnimeImagesInBackground];
}

- (void) testConnectionFail {
    NSLog(@"no connection");
    [self progressStop];
}


- (void) updateStatusWithTimer: (NSTimer*)timer {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSUInteger hits = 0;
        
        for (MSCAnime* anime in self.animes) {
            NSArray* aTorrents = [shared.ruby searchTorrentsForAnime:anime];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                [anime updateStatus: aTorrents];
            });
            
            if (aTorrents.count > 0)
            {
                hits += 1;
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self notifyDockWithHits:hits];
                });
            }
        }
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self notifyDockWithHits:hits];
        });
    });
}

- (void) notifyDockWithHits:(NSUInteger)hits
{
    NSDockTile *tile = [[NSApplication sharedApplication] dockTile];
    if (hits > 0) {
        [tile setBadgeLabel:[NSString stringWithFormat:@"%ld", hits]];
    } else {
        [tile setBadgeLabel:nil];
    }
}

- (void) updateAnimeImagesInBackground
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        for (Anime* anime in self.animes) {
            
            if (anime.imageUrl == nil) {
                NSString* url = [shared.ruby imageUrl2:anime];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    anime.imageUrl = url;
                });
            } else {
                NSLog(@"anime image url: %@", anime.imageUrl);
            }
        }
    });
}

- (IBAction) searchTorrents:(id)sender
{
    self.currentAnime = [self anime];
    [self progressStart];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray* torrentsArray = [shared.ruby searchTorrentsForAnime:self.currentAnime];
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.torrents = torrentsArray;
            [self progressStop];
        });
    });
}

- (IBAction) getTorrent:(id)sender
{
    [self progressStart];
    [self writeToPasteBoard:[[self torrent] link]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [shared.transmission torrentAdd:[[self torrent] link]];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self progressStop];
        });
    });
}

- (IBAction) queryTorrent:(id)sender
{
    self.torrents = [shared.ruby searchTorrents: self.torrentQuery.stringValue];
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

- (void) logError: (NSError*)error inMethod:(NSString*)method {
    NSLog(@"ERROR: %@ - %@, %@", method, error, error.userInfo);
}

@end
