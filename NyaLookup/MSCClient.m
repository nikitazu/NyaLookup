//
//  MSCClient.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 20.02.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "MSCClient.h"

@implementation MSCClient

+ (id) client:(MSCPreferences*)prefs
{
    MSCClient* client = [[MSCClient alloc] init];
    if (client == nil) {
        return nil;
    }
    
    client.preferences = prefs;
    return client;
}

- (NSArray*) searchTorrents:(NSString*)terms
{
    NSString* query = [@"terms=" stringByAppendingString: terms];
    NSString*   url = [self get:@"torrent/search" withData: query];
    NSArray*   json = [NSArray jsonArrayWithUrl:url];
    NSMutableArray* items = [[NSMutableArray alloc] init];
    
    for (id j in json) {
        [items addObject: [[MSCTorrent alloc] initWithDictionary:j]];
    }
    
    return items;
}

- (NSArray*) searchTorrentsForAnime:(MSCAnime*)anime
{
    return [self searchTorrents: [anime queryTorrents]];
}

- (NSArray*) indexAnime
{
    NSString*         url = [self get: @"anime/index.json"];
    NSArray*         json = [NSArray jsonArrayWithUrl: url];
    NSMutableArray* items = [[NSMutableArray alloc] init];
    
    for (id j in json) {
        [items addObject: [[MSCAnime alloc] initWithDictionary:j]];
    }
    
    return items;
}

- (NSString*) get: (NSString*)method
{
    return [NSString stringWithFormat: @"http://%@/%@",
            self.preferences.server,
            method];
}

- (NSString*) get: (NSString*)method withData: (NSString*)data
{
    return [NSString stringWithFormat: @"http://%@/%@?%@",
            self.preferences.server,
            method,
            [data quote]];
}

@end
