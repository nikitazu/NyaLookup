//
//  MSCAppDelegate.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 18.02.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "MSCAppDelegate.h"

@implementation MSCAppDelegate

@synthesize animes;
@synthesize animesController;

@synthesize torrents;
@synthesize torrentsController;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.animes = [MSCAnime loadItems];
    
    id x1 = [self tor:@"foo"];
    id x2 = [self tor:@"bar"];
    id x3 = [self tor:@"buz"];
    
    NSArray* arr = @[ x1, x2, x3 ];
    NSLog(@"%@", arr);
    
    self.torrents = arr;
}

- (NSDictionary*) tor: (NSString*)name
{
    return @{ @"title": name,
              @"link": @"http://foo.bar/buz",
              @"seeds": @"3",
              @"peers": @"200" };
}

@end
