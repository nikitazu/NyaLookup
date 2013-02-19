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

/// @Login to access anime usage data on the web
- (NSString*) login;

/// @Reset all settings to their default values
- (void) reset;

@end
