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

- (IBAction)importWatching:(id)sender {
    NSLog(@"importWatching");
    
    NSArray* animes = [shared.ruby indexAnime];
    
    for (MSCAnime* anime in animes) {
        NSLog(@"importing %@", anime.title);
        Anime* newAnime = [shared insertEntity:@"Anime"];
        [newAnime initWithAnime:anime];
        [shared.root addAnimesObject:newAnime];
    }
    
    NSError* error;
    if ([shared.context save:&error] != YES) {
        [self logError:error inMethod:@"importWatching/save"];
        return;
    }
    
    NSLog(@"exporting animes completed");
}

- (IBAction)importCompleted:(id)sender {
    NSLog(@"importCompleted");
}

- (IBAction)clearAll:(id)sender {
    NSLog(@"clearAll");
    for (id anime in shared.root.animes) {
        [shared.context deleteObject: anime];
    }
    
    NSError* error;
    if ([shared.context save:&error] == YES) {
        NSLog(@"data cleared");
    }
    else
    {
        [self logError:error inMethod:@"clearAll/save"];
    }
    
}

- (void) logError: (NSError*)error inMethod:(NSString*)method {
    NSLog(@"ERROR: menu - %@ - %@, %@", method, error, error.userInfo);
}

@end
