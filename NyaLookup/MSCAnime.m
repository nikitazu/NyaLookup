//
//  MSCAnime.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 18.02.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "MSCAnime.h"

@implementation MSCAnime

@synthesize title;
@synthesize score;
@synthesize type;
@synthesize airing;
@synthesize current;
@synthesize max;

- (NSString*) progress
{
    if (self.max > 0) {
        return [NSString stringWithFormat:@"%ld / %ld", self.current, self.max, nil];
    } else {
        return [NSString stringWithFormat:@"%ld / -", self.current, nil];
    }
}

- (NSString*) queryTerms
{
    return [NSString stringWithFormat:@"http://localhost:3000/torrent/search?terms=%@+%ld",
            [self.title stringByReplacingOccurrencesOfString:@" " withString:@"+"],
            self.current + 1,
            nil];
}

+ (NSArray*) loadItems
{
    NSArray* json = [NSArray jsonArrayWithUrl:@"http://localhost:3000/anime/index.json"];
    NSMutableArray* items = [[NSMutableArray alloc] init];
    
    for (id j in json) {
        [items addObject: [[MSCAnime alloc] initWithDictionary:j]];
    }
    
    return items;
}

- (id) initWithDictionary:(NSDictionary*)data
{
    if (self)
    {
        self.title = [data objectForKey:@"title"];
        self.score = [[data objectForKey:@"score"] integerValue];
        self.type  = [data objectForKey:@"type"];
        self.airing = [[data objectForKey:@"airing"] integerValue] == 1;
        self.current = [[data objectForKey:@"current"] integerValue];
        self.max = [[data objectForKey:@"max"] integerValue];
    }
    return self;
}

- (NSArray*) findTorrents
{
    NSString* url = [self queryTerms];
    
    NSLog(@"findTorrents: %@", url);
    
    NSArray* json = [NSArray jsonArrayWithUrl:url];
    NSMutableArray* items = [[NSMutableArray alloc] init];
    
    for (id j in json) {
        [items addObject: [[MSCTorrent alloc] initWithDictionary:j]];
    }
    
    return items;
}

@end
