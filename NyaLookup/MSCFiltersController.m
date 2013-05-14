//
//  MSCFiltersController.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 12.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "MSCFiltersController.h"

@implementation MSCFiltersController

- (IBAction)pending:(id)sender {
    NSLog(@"filter pending");
    [self updateAnimes:[self.shared.root filterPending]];
}

- (IBAction)watching:(id)sender {
    NSLog(@"filter watching");
    [self updateAnimes:[self.shared.root filterWatching]];
}

- (IBAction)complteted:(id)sender {
    NSLog(@"filter completed");
    [self updateAnimes:[self.shared.root filterCompleted]];
}

- (IBAction)onHold:(id)sender {
    NSLog(@"filter onHold");
    [self updateAnimes:[self.shared.root filterOnHold]];
}

- (IBAction)dropped:(id)sender {
    NSLog(@"filter dropped");
    [self updateAnimes:[self.shared.root filterDropped]];
}

- (void) updateAnimes: (id)animes {
    [self.main setAnimes: animes];
    [self updateImagesFor: animes];
}



- (void) updateImagesFor:(NSArray*)animes
{
    MSCImageCache* cache = [MSCImageCache singleton];
    MSCRuby* ruby = [MSCRuby singleton];
    NSString* task = @"updateImagesForAnimes";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[MSCBackgroundManager singleton] registerTask:task];
        for (Anime* anime in animes) {
            if (anime.imageUrl == nil) {
                
                NSString* url = [ruby imageUrl2:anime];
                NSString* file = [cache cacheImage:url];
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    
                    if (![[MSCBackgroundManager singleton] isTaskRegistered:task]) {
                        NSLog(@"cancelling task iteration: %@", task);
                        return; // cancels syncronous lambda
                    }
                    
                    anime.imageUrl = url;
                    anime.imageFile = file;
                    
                    NSError* error;
                    if ([self.shared.context save:&error] == NO) {
                        [self logError:error inMethod:@"updateImagesFor/animes/save"];
                    }
                });
                
                if (![[MSCBackgroundManager singleton] isTaskRegistered:task]) {
                    NSLog(@"breaking task loop: %@", task);
                    break; // breaking tasks loop
                }
            }
        }
    });
}

@end
