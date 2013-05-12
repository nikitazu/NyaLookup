//
//  Anime+Compatibility.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 12.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "Anime+Compatibility.h"

@implementation Anime (Compatibility)

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


- (NSInteger) next {
    NSInteger result = self.current + 1;
    NSInteger max = self.series.intValue;
    
    return result > max ? max : result;
}

- (NSInteger) current {
    if (self.lastWatch == nil) {
        return 0;
    } else {
        return self.lastWatch.progress.intValue;
    }
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


- (bool)isPending {
    return self.watches.count == 0;
}

- (bool)isWatching {
    return self.lastWatch != nil &&
        self.lastWatch.progress < self.series &&
        self.lastWatch.onHold == [NSNumber numberWithBool:NO] &&
        self.lastWatch.dropped == [NSNumber numberWithBool:NO];
}

- (bool)isCompleted {
    return self.lastWatch != nil &&
        self.lastWatch.progress == self.series &&
        self.lastWatch.onHold == [NSNumber numberWithBool:NO] &&
        self.lastWatch.dropped == [NSNumber numberWithBool:NO];
}

- (bool)isOnHold {
    return self.lastWatch != nil && self.lastWatch.onHold == [NSNumber numberWithBool:NO];
}

- (bool)isDropped {
    return self.lastWatch != nil && self.lastWatch.dropped == [NSNumber numberWithBool:NO];
}


@end
