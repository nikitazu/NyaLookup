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

+ (id)singleton;

- (NSString*) ruby;
- (NSString*) nyafind;
- (NSString*) nyasearch;
- (NSString*) nyalist;
- (NSString*) nyaimage;
- (NSString*) cachePath;
- (NSString*) transmissionServer;

/// @Reset all settings to their default values
- (void) reset;

@end
