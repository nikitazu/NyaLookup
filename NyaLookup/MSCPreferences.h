//
//  MSCPreferences.h
//  NyaLookup
//
//  Created by Никита Б. Зуев on 18.02.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>

/// Preferences of client software
///
@interface MSCPreferences : NSObject
{
    NSUserDefaults* _prefs;
}

/// Nice static @constructor
+ (id)preferences;

- (NSString*) ruby;
- (NSString*) nyafind;
- (NSString*) nyasearch;
- (NSString*) nyalist;
- (NSString*) nyaimage;

- (NSString*) transmissionServer;

- (NSString*) retreiveImageForLink:(NSString*)link;
- (void) cacheImage:(NSString*)imageUrl forLink:(NSString*)link;

/// @Reset all settings to their default values
- (void) reset;

@end
