//
//  Anime.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 12.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "Anime.h"
#import "Root.h"


@implementation Anime

@dynamic title;
@dynamic score;
@dynamic type;
@dynamic airing;
@dynamic series;
@dynamic link;
@dynamic imageUrl;
@dynamic root;

- (void) initWithAnime: (MSCAnime*)anime {
    self.title = anime.title;
    self.score = [NSNumber numberWithInt:anime.score];
    self.type = anime.type;
    self.airing = [NSNumber numberWithBool:anime.airing];
    self.series = [NSNumber numberWithInt:anime.max];
    self.link = anime.link;
    self.imageUrl = nil;
    self.imageNSURL = nil;
}

// msc compatibility

@synthesize status;
@synthesize statusColor;
@synthesize imageNSURL;

- (NSInteger) max {
    NSLog(@"MMMMMMAAAAAAAXXXXXXXX: %@", self.title);
    return [self.series intValue];
}

- (NSInteger) next {
    return 1;
}

- (NSInteger) current {
    return 1;
}

- (NSString*) progress
{
    if (self.series > 0) {
        return [NSString stringWithFormat:@"%ld / %@", self.current, self.series];
    } else {
        return [NSString stringWithFormat:@"%ld / -", self.current];
    }
}

- (void) updateStatus: (NSArray*)torrents
{
    if (torrents.count == 1)
    {
        self.statusColor = [NSColor blueColor];
        self.status = NSLocalizedStringFromTable(@"OneTorrent", nil, nil);
    }
    else if (torrents.count > 1)
    {
        self.statusColor = [NSColor blueColor];
        self.status = [NSString stringWithFormat:
                       NSLocalizedStringFromTable(@"TorrentsFound", nil, nil),
                       torrents.count];
    } else {
        self.statusColor = [NSColor lightGrayColor];
        self.status = NSLocalizedStringFromTable(@"NoTorrents", nil, nil);
    }
}

@end
