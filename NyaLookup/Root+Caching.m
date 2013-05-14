//
//  Root+Caching.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 14.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "Root+Caching.h"
#import "ImageCache+Checks.h"
#import "MSCImageCache.h"
#import "MSCRuby.h"
#import "MSCBackgroundManager.h"

@implementation Root (Caching)

- (ImageCache*) findCacheFor: (Anime*)anime {
    
    for (ImageCache* c in self.imageCaches.allObjects) {
        if ([c.animeUrl isEqualToString: anime.link]) {
            NSLog(@"found in cache %@", anime.title);
            return c;
        }
    }
    
    return nil;
}


- (void) updateImagesFor:(NSArray*)animes inShared: (MSCShared*)shared {
    if (animes == nil || shared == nil) {
        NSLog(@"updateImagesFor/animes/inShared skip");
        return;
    }
    
    MSCImageCache* cache = [MSCImageCache singleton];
    MSCRuby* ruby = [MSCRuby singleton];
    NSString* task = @"updateImagesForAnimes";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[MSCBackgroundManager singleton] registerTask:task];
        for (Anime* anime in animes) {
            if ([self notRegistered:task]) {
                break;
            }
            
            ImageCache* icache = [self findCacheFor:anime];
            
            if (icache == nil) {
                NSLog(@"caching anime %@", anime.title);
                icache = [shared insertEntity:@"ImageCache"];
                icache.animeUrl = anime.link;
                [self addImageCachesObject:icache];
            }
            
            if (icache.imageUrl == nil) {
                icache.imageUrl = [ruby imageUrl2:anime];
            }
            
            if (!icache.fileExists) {
                icache.fileUrl = [cache cacheImage:icache.imageUrl withName:anime.title];
            }
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                if ([self notRegistered:task]) {
                    return;
                }
                
                anime.imageUrl = icache.imageUrl;
                anime.imageFile = icache.fileUrl;
                
                NSError* error;
                if ([shared.context save:&error] == NO) {
                    [self logError:error inMethod:@"updateImagesFor/animes/save"];
                }
            });
            
            if ([self notRegistered:task]) {
                break;
            }
        }
    });
}

- (void) updateImageFor:(Anime*)anime inShared: (MSCShared*)shared {
    if (anime == nil || shared == nil) {
        NSLog(@"updateImageFor/anime/inShared skip");
        return;
    }
    
    MSCImageCache* cache = [MSCImageCache singleton];
    MSCRuby* ruby = [MSCRuby singleton];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            ImageCache* icache = [self findCacheFor:anime];
            
            if (icache == nil) {
                NSLog(@"caching anime %@", anime.title);
                icache = [shared insertEntity:@"ImageCache"];
                icache.animeUrl = anime.link;
                [self addImageCachesObject:icache];
            }
            
            if (icache.imageUrl == nil) {
                icache.imageUrl = [ruby imageUrl2:anime];
            }
            
            if (!icache.fileExists) {
                icache.fileUrl = [cache cacheImage:icache.imageUrl withName:anime.title];
            }
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                anime.imageUrl = icache.imageUrl;
                anime.imageFile = icache.fileUrl;
                
                NSError* error;
                if ([shared.context save:&error] == NO) {
                    [self logError:error inMethod:@"updateImageFor/anime/save"];
                }
            });
    });
}


- (bool) notRegistered: (NSString*)task {
    if (![[MSCBackgroundManager singleton] isTaskRegistered:task]) {
        NSLog(@"breaking task loop: %@", task);
        return YES;
    }
    return NO;
}

- (void) logError: (NSError*)error inMethod:(NSString*)method {
    NSLog(@"ERROR: %@ - %@, %@", method, error, error.userInfo);
}

@end
