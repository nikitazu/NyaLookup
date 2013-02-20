//
//  MSCTorrent.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 18.02.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "MSCTorrent.h"

@implementation MSCTorrent

@synthesize title;
@synthesize category;
@synthesize link;
@synthesize seed;
@synthesize leech;
@synthesize down;
@synthesize description;

- (NSString*) peers
{
    return [NSString stringWithFormat:@"%@ / %@", self.seed, self.leech, nil];
}

- (id) initWithDictionary:(NSDictionary*)data
{
    if (self)
    {
        self.title = [data objectForKey:@"title"];
        self.category = [data objectForKey:@"category"];
        self.link = [data objectForKey:@"link"];
        self.seed = [data objectForKey:@"seed"];
        self.leech = [data objectForKey:@"leech"];
        self.down = [data objectForKey:@"down"];
        self.description = [data objectForKey:@"description"];
    }
    return self;
}

+ (NSArray*) query:(NSString*)terms
{
    NSString* url = [NSString stringWithFormat:@"http://localhost:3000/torrent/search?terms=%@",
                     [terms quote],
                     nil];
    
    //NSLog(@"query torrents: %@", url);
    
    NSArray* json = [NSArray jsonArrayWithUrl:url];
    NSMutableArray* items = [[NSMutableArray alloc] init];
    
    for (id j in json) {
        [items addObject: [[MSCTorrent alloc] initWithDictionary:j]];
    }
    
    return items;
}

@end
