//
//  MSCMenuController.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 12.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "MSCMenuController.h"

@implementation MSCMenuController

@synthesize shared;

- (IBAction)importPending:(id)sender {
    [self importWithStatus:@"pending"];
}

- (IBAction)importWatching:(id)sender {
    [self importWithStatus:@"watching"];
}

- (IBAction)importCompleted:(id)sender {
    [self importWithStatus:@"completed"];
}

- (IBAction)importOnHold:(id)sender {
    [self importWithStatus:@"onhold"];
}

- (IBAction)importDropped:(id)sender {
    [self importWithStatus:@"dropped"];
}


- (void) importWithStatus:(NSString*)status {
    NSLog(@"importing stage %@", status);
    
    NSArray* animes = [shared.ruby indexAnimeWithStatus:status];
    
    for (MSCAnime* anime in animes) {
        NSLog(@"importing %@", anime.title);
        Anime* newAnime = [shared insertEntity:@"Anime"];
        [newAnime initWithAnime:anime];
        [self.shared.root addAnimesObject:newAnime];
        
        if ([status isEqualToString:@"pending"]) {
            continue;
        }
        
        Watch* watch = [shared insertEntity:@"Watch"];
        watch.created = [NSDate date];
        watch.updated = [NSDate date];
        watch.progress = [NSNumber numberWithInt:anime.current];
        watch.onHold = [NSNumber numberWithBool:NO];
        watch.dropped = [NSNumber numberWithBool:NO];
        [newAnime addWatchesObject:watch];
        newAnime.lastWatch = watch;
        
        if ([status isEqual: @"completed"])
        {
            watch.progress = [NSNumber numberWithInt:anime.max];
        }
        else if ([status isEqualToString:@"onhold"])
        {
            watch.onHold = [NSNumber numberWithBool:YES];
        }
        else if([status isEqualToString:@"dropped"])
        {
            watch.dropped = [NSNumber numberWithBool:YES];
        }
    }
    
    if ([self.shared saveContex]) {
        NSLog(@"importing stage completed");
    }
}



- (IBAction)clearAll:(id)sender {
    NSLog(@"clearing all data");
    
    [[MSCBackgroundManager singleton] stopTask:@"updateImagesForAnimes"];
    
    [self.main setAnimes: nil];
    
    for (id anime in shared.root.animes) {
        [self.shared.context deleteObject: anime];
        [[NSFileManager defaultManager] removeItemAtPath:[anime imageFile] error:nil];
    }
    
    if ([self.shared saveContex]) {
        NSLog(@"data cleared");
    }
}

- (void) logError: (NSError*)error inMethod:(NSString*)method {
    NSLog(@"ERROR: menu - %@ - %@, %@", method, error, error.userInfo);
}

@end
