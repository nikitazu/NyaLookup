//
//  MSCPreferences.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 18.02.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "MSCPreferences.h"

NSString *const MSC_PREFERENCES_PATH =
    @"~/Library/Preferences/ru.massoc.NyaLookup.plist";

@implementation MSCPreferences

+ (id)preferences {
    return [[MSCPreferences alloc] init];
}

- (id)init {
    self = [super init];
    if (self) {
        NSMutableDictionary* defaults = [NSMutableDictionary new];
        
        [defaults setObject:@"unknown" forKey:@"login"];
        
        _prefs = [NSUserDefaults standardUserDefaults];
        [_prefs registerDefaults:defaults];
    }
    return self;
}


// Login to access anime usage data on the web
- (NSString*) login {
    return [_prefs valueForKey:@"login"];
}

- (void) reset {
    [_prefs setObject:@"unknown" forKey:@"login"];
}

@end
