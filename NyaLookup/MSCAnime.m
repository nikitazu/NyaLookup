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

+ (NSArray*) loadItems
{
    NSData*  data = [MSCRest curl: @"http://localhost:3000/anime/index.json"];
    NSError* error;
    NSArray* json = [NSJSONSerialization
                          JSONObjectWithData:data
                          options:kNilOptions
                          error:&error];
    
    if (error) {
        NSLog(@"ERROR: %@", error);
    }
    
    /*NSMutableArray* items = [[NSMutableArray alloc] init];
    for (id j in json) {
        
        MSCAnime* a = [[MSCAnime alloc] init];
        a.title = [j objectForKey:@"title"];
        a.type = [j objectForKey:@"type"];
        
        [items addObject:a];
    }*/
    
    //NSLog(@"%@", json[0]);
    
    return json;
}

- (NSArray*) findTorrents
{
    // todo
    return nil;
}

@end
