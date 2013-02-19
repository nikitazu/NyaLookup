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
    
    NSMutableArray* items = [[NSMutableArray alloc] init];
    for (id j in json) {
        [items addObject: [[MSCAnime alloc] initWithDictionary:j]];
    }
    
    //NSLog(@"%@", json[0]);
    
    return json;
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
    // todo
    return nil;
}

@end
