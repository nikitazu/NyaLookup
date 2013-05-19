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
        (self.lastWatch.progress < self.series || self.series.intValue == 0) &&
        self.lastWatch.onHold.boolValue == NO &&
        self.lastWatch.dropped.boolValue == NO;
}

- (bool)isCompleted {
    return self.lastWatch != nil &&
        self.series.intValue != 0 &&
        self.lastWatch.progress == self.series &&
        self.lastWatch.onHold.boolValue == NO &&
        self.lastWatch.dropped.boolValue == NO;
}

- (bool)isOnHold {
    return self.lastWatch != nil &&
        self.lastWatch.onHold.boolValue == YES &&
        self.lastWatch.dropped.boolValue == NO;
}

- (bool)isDropped {
    return self.lastWatch != nil && self.lastWatch.dropped.boolValue == YES;
}


- (bool)incrementSeries {
    if (self.isPending) {
        NSLog(@"%@ - cannot increment pending series", self.title);
        return NO;
    } else {
        return [self.lastWatch increment];
    }
}

- (bool)decrementSeries {
    if (self.isPending) {
        NSLog(@"%@ - cannot decrement pending series", self.title);
        return NO;
    } else {
        return [self.lastWatch decrement];
    }
}

- (void)setPending {
    [self removeWatches: self.watches];
    self.lastWatch = nil;
}

- (void)watch:(Watch *)newWatch {
    newWatch.created = [NSDate date];
    newWatch.updated = [NSDate date];
    newWatch.progress = [NSNumber numberWithInt:self.current];
    newWatch.onHold = [NSNumber numberWithBool:NO];
    newWatch.dropped = [NSNumber numberWithBool:NO];
    
    [self addWatchesObject:newWatch];
    self.lastWatch = newWatch;
}

- (BOOL)complete {
    if (self.lastWatch == nil) {
        NSLog(@"cannot complete %@, not watching", self.title);
        return NO;
    }
    
    self.lastWatch.progress = self.series;
    self.lastWatch.onHold = [NSNumber numberWithBool:NO];
    self.lastWatch.dropped = [NSNumber numberWithBool:NO];
    return YES;
}

- (BOOL)hold {
    if (self.lastWatch == nil) {
        NSLog(@"cannot hold %@, not watching", self.title);
        return NO;
    }
    
    if (self.lastWatch.dropped.boolValue) {
        NSLog(@"cannot hold %@, is dropped", self.title);
        return NO;
    }
    
    self.lastWatch.onHold = [NSNumber numberWithBool:YES];
    return YES;
}

- (BOOL)drop {
    if (self.lastWatch == nil) {
        NSLog(@"cannot drop %@, not watching", self.title);
        return NO;
    }
    
    self.lastWatch.dropped = [NSNumber numberWithBool:YES];
    return YES;
}


@end
