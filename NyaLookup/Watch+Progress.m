//
//  Watch+Progress.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 14.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "Watch+Progress.h"
#import "Anime.h"

@implementation Watch (Progress)

- (bool) increment {
    if (self.anime.series.intValue <= 0) {
        NSLog(@"%@ increment skip - anime series <= 0", self.anime.title);
        return NO;
    }
    
    if (self.progress.intValue >= self.anime.series.intValue) {
        NSLog(@"%@ increment skip - progress >= anime series", self.anime.title);
        return NO;
    }
    
    NSLog(@"%@ increment", self.anime.title);
    self.progress = [NSNumber numberWithInt:self.progress.intValue + 1];
    return YES;
}

- (bool) decrement {
    if (self.progress.intValue <= 0) {
        NSLog(@"%@ decrement skip - progress <= 0", self.anime.title);
        return NO;
    }
    
    NSLog(@"%@ decrement", self.anime.title);
    self.progress = [NSNumber numberWithInt:self.progress.intValue - 1];
    return YES;
}

@end
