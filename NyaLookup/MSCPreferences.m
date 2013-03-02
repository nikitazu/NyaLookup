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
        
        [defaults setObject:@"localhost:3000"
                     forKey:@"server"];
        [defaults setObject:@"/Users/nikitazu/.rvm/bin/ruby"
                     forKey:@"ruby"];
        [defaults setObject:@"/Users/nikitazu/prj/oss/nyafind/nyafind.rb"
                     forKey:@"nyafind"];
        [defaults setObject:@"/Users/nikitazu/prj/oss/nyafind/nyasearch.rb"
                     forKey:@"nyasearch"];
        [defaults setObject:@"/Users/nikitazu/prj/oss/nyafind/nyalist.rb"
                     forKey:@"nyalist"];
        
        _prefs = [NSUserDefaults standardUserDefaults];
        [_prefs registerDefaults:defaults];
    }
    return self;
}


// Server to access anime usage data on the web
- (NSString*) server {
    return [_prefs valueForKey:@"server"];
}

- (NSString*) ruby {
    return [_prefs valueForKey:@"ruby"];
}

- (NSString*) nyafind {
    return [_prefs valueForKey:@"nyafind"];
}

- (NSString*) nyasearch {
    return [_prefs valueForKey:@"nyasearch"];
}

- (NSString*) nyalist {
    return [_prefs valueForKey:@"nyalist"];
}

- (void) reset {
    [_prefs setObject:@"localhost:3000"
               forKey:@"server"];
    [_prefs setObject:@"/Users/nikitazu/.rvm/bin/ruby"
               forKey:@"ruby"];
    [_prefs setObject:@"/Users/nikitazu/prj/oss/nyafind/nyafind.rb"
               forKey:@"nyafind"];
    [_prefs setObject:@"/Users/nikitazu/prj/oss/nyafind/nyasearch.rb"
               forKey:@"nyasearch"];
    [_prefs setObject:@"/Users/nikitazu/prj/oss/nyafind/nyalist.rb"
               forKey:@"nyalist"];
}

@end
