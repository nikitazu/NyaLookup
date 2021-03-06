//
//  MSCPreferences.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 18.02.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "MSCPreferences.h"

@implementation MSCPreferences

+ (id)singleton
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // <-- my code here
    });
    return _sharedObject;
}

- (id)init {
    self = [super init];
    if (self) {
        NSMutableDictionary* defaults = [NSMutableDictionary new];

        [defaults setObject:@"/Users/nikitazu/.rvm/bin/ruby"
                     forKey:@"ruby"];
        [defaults setObject:@"/Users/nikitazu/prj/oss/nyafind/nyafind.rb"
                     forKey:@"nyafind"];
        [defaults setObject:@"/Users/nikitazu/prj/oss/nyafind/nyasearch.rb"
                     forKey:@"nyasearch"];
        [defaults setObject:@"/Users/nikitazu/prj/oss/nyafind/nyalist.rb"
                     forKey:@"nyalist"];
        [defaults setObject:@"/Users/nikitazu/prj/oss/nyafind/nyaimage.rb"
                     forKey:@"nyaimage"];
        [defaults setObject:@"http://zeus:9091/transmission/rpc"
                     forKey:@"transmissionServer"];
        
        _prefs = [NSUserDefaults standardUserDefaults];
        [_prefs registerDefaults:defaults];
    }
    return self;
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

- (NSString*) nyaimage {
    return [_prefs valueForKey:@"nyaimage"];
}

- (NSString*) transmissionServer {
    return [_prefs valueForKey:@"transmissionServer"];
}

- (void) reset {
    [_prefs setObject:@"/Users/nikitazu/.rvm/bin/ruby"
               forKey:@"ruby"];
    [_prefs setObject:@"/Users/nikitazu/prj/oss/nyafind/nyafind.rb"
               forKey:@"nyafind"];
    [_prefs setObject:@"/Users/nikitazu/prj/oss/nyafind/nyasearch.rb"
               forKey:@"nyasearch"];
    [_prefs setObject:@"/Users/nikitazu/prj/oss/nyafind/nyalist.rb"
               forKey:@"nyalist"];
    [_prefs setObject:@"/Users/nikitazu/prj/oss/nyafind/nyaimage.rb"
               forKey:@"nyaimage"];
    [_prefs setObject:@"http://zeus:9091/transmission/rpc"
               forKey:@"transmissionServer"];
}


@end
