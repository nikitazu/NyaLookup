//
//  MSCRuby.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 02.03.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "MSCRuby.h"

@implementation MSCRuby

+ (id)singleton
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // <-- my code here
    });
    return _sharedObject;
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

- (NSArray*) searchTorrentsForAnime2:(Anime*)anime
{
    NSLog(@"ruby searchTorrentsForAnime2: %@", anime.title);
    
    NSMutableArray* args = [NSMutableArray arrayWithObject:self.preferences.nyasearch];
    NSString* animeTitle = [self removeCrazyCharacters:anime.title];
    
    for (id item in [animeTitle componentsSeparatedByString:@" "]) {
        [args addObject:item];
    }
    
    // todo: write more generic algorithm (001/100, 010/100 etc..)
    if (anime.series.intValue > 9 && anime.next < 10) {
        [args addObject:[NSString stringWithFormat:@"0%ld", anime.next]];
    }
    else {
        [args addObject:[NSString stringWithFormat:@"%ld", anime.next]];
    }
    
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

- (NSArray*) indexAnimeWithStatus: (NSString*)status
{
    NSArray* json = [[self run:@[self.preferences.nyalist, @"nikitazu", status]] json];
    return [json map: ^(id j) {
        return [[MSCAnime alloc] initWithDictionary:j];
    }];
}

- (NSString*) imageUrl2: (Anime*)anime
{
    NSLog(@"ruby imageUrl2: %@", anime.link);
    
    NSString* animeLink = [self encodeCrazyCharacters: anime.link];
    
    if (![anime.link hasPrefix:@"http://myanimelist"]) {
        return anime.imageUrl;
    }
    
    NSData* data = [self run:@[self.preferences.nyaimage, animeLink]];
    NSString* string = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
    
    NSString* trimmed = [string stringByTrimmingCharactersInSet:
                         [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSLog(@"ruby imageUrl2 returns: %@", trimmed);
    
    return trimmed;
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
    //NSLog(@"encodeCrayCharacters: %@", string);
    NSString* temp = [string stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    temp = [temp stringByReplacingOccurrencesOfString:@"☆"
                                             withString:@"%E2%98%86"];
    temp = [temp stringByReplacingOccurrencesOfString:@"½"
                                             withString:@"%BD"];
    //NSLog(@"encode done: %@", temp);
    return temp;
}

- (NSString*) removeCrazyCharacters: (NSString*)string
{
    //NSLog(@"remove crazy chars: %@", string);
    NSString* temp = string;
    NSArray* badChars = [NSArray arrayWithObjects:@"♪", @"☆", @"½", @"é", @"è", @"à", nil];
    for (NSString* badChar in badChars) {
        temp = [temp stringByReplacingOccurrencesOfString:badChar
                                                 withString:@" "];
    }
    //NSLog(@"remove done: %@", temp);
    return temp;
}

- (MSCPreferences*) preferences {
    return [MSCPreferences singleton];
}


@end
