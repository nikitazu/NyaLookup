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
    NSArray* json = [[self.preferences.server get:@"torrent/search"
                                         withData: query] curlJson];
    
    return [json map: ^(id j) {
        return [[MSCTorrent alloc] initWithDictionary:j];
    }];
}

- (NSArray*) searchTorrentsForAnime:(MSCAnime*)anime
{
    NSString* method = [NSString stringWithFormat:@"torrent/search/%ld/%@",
                        anime.next,
                        [anime queryTorrents]];
    
    NSArray* json = [[self.preferences.server get:method] curlJson];
    
    return [json map: ^(id j) {
        return [[MSCTorrent alloc] initWithDictionary:j];
    }];
}

- (NSArray*) indexAnime
{
    NSArray* json = [[self.preferences.server get: @"anime/index.json"] curlJson];
    
    return [json map: ^(id j) {
        return [[MSCAnime alloc] initWithDictionary:j];
    }];
}

@end
