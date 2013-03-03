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
@synthesize next;
@synthesize max;
@synthesize status;
@synthesize statusColor;

- (NSString*) progress
{
    if (self.max > 0) {
        return [NSString stringWithFormat:@"%ld / %ld", self.current, self.max];
    } else {
        return [NSString stringWithFormat:@"%ld / -", self.current];
    }
}

- (id) initWithDictionary:(NSDictionary*)data
{
    if (self)
    {
        self.title       = [data objectForKey:@"title"];
        self.score       = [[data objectForKey:@"score"] integerValue];
        self.type        = [data objectForKey:@"type"];
        self.airing      = [[data objectForKey:@"airing"] integerValue] == 1;
        self.current     = [[data objectForKey:@"current"] integerValue];
        self.next        = self.current + 1;
        self.max         = [[data objectForKey:@"max"] integerValue];
        self.status      = @"unchecked";
        self.statusColor = [NSColor lightGrayColor];
    }
    return self;
}

- (void) updateStatus: (NSArray*)torrents
{
    if (torrents.count > 0) {
        self.statusColor = [NSColor blueColor];
        self.status = [NSString stringWithFormat:
                       @"torrent(s) found: %ld", torrents.count];
    } else {
        self.statusColor = [NSColor lightGrayColor];
        self.status = @"no torrents found";
    }
}

@end
