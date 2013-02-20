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
        
        [defaults setObject:@"localhost:3000" forKey:@"server"];
        
        _prefs = [NSUserDefaults standardUserDefaults];
        [_prefs registerDefaults:defaults];
    }
    return self;
}


// Server to access anime usage data on the web
- (NSString*) server {
    return [_prefs valueForKey:@"server"];
}

- (void) reset {
    [_prefs setObject:@"localhost:3000" forKey:@"server"];
}

@end
