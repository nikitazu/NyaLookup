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
    NSMutableArray* args = [NSMutableArray arrayWithObject:self.preferences.nyasearch];
    for (id item in [anime.title componentsSeparatedByString:@" "]) {
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


@end
