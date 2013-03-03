//
//  MSCPreferences.h
//  NyaLookup
//
//  Created by Никита Б. Зуев on 18.02.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>

/// Path to save preferences of this application
FOUNDATION_EXPORT NSString *const MSC_PREFERENCES_PATH;

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

- (NSString*) transmissionServer;

/// @Reset all settings to their default values
- (void) reset;

@end
