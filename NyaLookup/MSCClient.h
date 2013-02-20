//
//  MSCClient.h
//  NyaLookup
//
//  Created by Никита Б. Зуев on 20.02.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSArray+JSON.h"
#import "NSString+Rest.h"
#import "NSData+JSON.h"
#import "MSCPreferences.h"
#import "MSCAnime.h"
#import "MSCTorrent.h"

@interface MSCClient : NSObject

@property (readwrite,retain) MSCPreferences* preferences;

+ (MSCClient*) client:(MSCPreferences*)prefs;
- (NSArray*) searchTorrents:(NSString*)terms;
- (NSArray*) searchTorrentsForAnime:(MSCAnime*)anime;
- (NSArray*) indexAnime;

@end
