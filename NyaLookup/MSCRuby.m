//
//  MSCRuby.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 02.03.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "MSCRuby.h"

@implementation MSCRuby

@synthesize preferences;


+ (id) client:(MSCPreferences*)prefs
{
    MSCRuby* client = [[MSCRuby alloc] init];
    if (client == nil) {
        return nil;
    }
    
    client.preferences = prefs;
    return client;
}

- (NSArray*) searchTorrents:(NSString*)terms
{
    NSMutableArray* args = [NSMutableArray arrayWithObject:self.preferences.nyafind];
    for (id item in [terms componentsSeparatedByString:@" "]) {
        [args addObject:item];
    }
    
    NSArray* json = [[self run:args] json];
    
    return [json map: ^(id j) {
        return [[MSCTorrent alloc] initWithDictionary:j];
    }];
}

- (NSArray*) searchTorrentsForAnime:(MSCAnime*)anime
{
    NSLog(@"ruby searchTorrentsForAnime: %@", anime.title);
    
    NSMutableArray* args = [NSMutableArray arrayWithObject:self.preferences.nyasearch];
    NSString* animeTitle = [self removeCrazyCharacters:anime.title];
    
    for (id item in [animeTitle componentsSeparatedByString:@" "]) {
        [args addObject:item];
    }
    [args addObject:[NSString stringWithFormat:@"%ld", anime.next]];
    
    NSArray* json = [[self run:args] json];
    
    return [json map: ^(id j) {
        return [[MSCTorrent alloc] initWithDictionary:j];
    }];
}

- (NSArray*) indexAnime
{
    NSArray* json = [[self run:@[self.preferences.nyalist, @"nikitazu"]] json];
    return [json map: ^(id j) {
        return [[MSCAnime alloc] initWithDictionary:j];
    }];
}

- (NSURL*) imageUrl: (MSCAnime*)anime
{
    NSLog(@"ruby imageUrl: %@", anime.link);
    
    NSString* animeLink = [self encodeCrazyCharacters: anime.link];
    
    NSString* cachedUrl = [self.preferences retreiveImageForLink:animeLink];
    if (cachedUrl != nil) {
        return [NSURL URLWithString:cachedUrl];
    }
    
    NSData* data = [self run:@[self.preferences.nyaimage, animeLink]];
    NSString* string = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
    
    NSString* trimmed = [string stringByTrimmingCharactersInSet:
                         [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSLog(@"ruby imageUrl returns: %@", trimmed);
    
    [self.preferences cacheImage:trimmed forLink:animeLink];
    
    return [NSURL URLWithString:trimmed];
}

- (NSData*)run:(NSArray*)args
{
    NSTask* task = [[NSTask alloc] init];
    NSPipe* tout = [NSPipe pipe];
    
    NSLog(@"run: %@", args);
    
    [task setLaunchPath: self.preferences.ruby];
    [task setArguments: args];
    [task setStandardOutput: tout];
    [task launch];
    
    NSData* data = [[tout fileHandleForReading] readDataToEndOfFile];
    [task waitUntilExit];
    return data;
}

- (NSString*) encodeCrazyCharacters: (NSString*)string
{
    return [string stringByReplacingOccurrencesOfString:@"☆"
                                             withString:@"%E2%98%86"];
}

- (NSString*) removeCrazyCharacters: (NSString*)string
{
    return [string stringByReplacingOccurrencesOfString:@"☆"
                                             withString:@" "];
}


@end
