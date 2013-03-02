//
//  MSCRuby.h
//  NyaLookup
//
//  Created by Никита Б. Зуев on 02.03.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSCPreferences.h"
#import "MSCAnime.h"
#import "MSCTorrent.h"
#import "NSData+JSON.h"
#import "NSArray+FP.h"

@interface MSCRuby : NSObject

@property (readwrite,retain) MSCPreferences* preferences;

+ (id) client:(MSCPreferences*)prefs;
- (NSArray*) searchTorrents:(NSString*)terms;
- (NSArray*) searchTorrentsForAnime:(MSCAnime*)anime;
- (NSArray*) indexAnime;

@end
