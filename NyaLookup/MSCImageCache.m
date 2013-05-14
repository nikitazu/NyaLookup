//
//  MSCImageCache.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 14.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "MSCImageCache.h"

@implementation MSCImageCache

@synthesize preferences;

+ (id) initWithPreferences:(MSCPreferences*)prefs {
    MSCImageCache* instance = [[MSCImageCache alloc] init];
    instance.preferences = prefs;
    return instance;
}

- (NSString*) cacheImage:(NSString*)url {
    NSString* saveto = [self pathForTemporaryFileWithPrefix:@"nya"];
    NSURL* uri = [NSURL URLWithString:url];
    NSData* data = [NSData dataWithContentsOfURL:uri];
    [data writeToFile:saveto atomically:YES];
    //NSLog(@"cachedImage in file: %@", saveto);
    return saveto;
}

- (NSString *)pathForTemporaryFileWithPrefix:(NSString *)prefix
{
    NSString *  result;
    CFUUIDRef   uuid;
    CFStringRef uuidStr;
    
    uuid = CFUUIDCreate(NULL);
    assert(uuid != NULL);
    
    uuidStr = CFUUIDCreateString(NULL, uuid);
    assert(uuidStr != NULL);
    
    result = [NSTemporaryDirectory() stringByAppendingPathComponent:
              [NSString stringWithFormat:@"%@-%@", prefix, uuidStr]];
    assert(result != nil);
    
    CFRelease(uuidStr);
    CFRelease(uuid);
    
    return result;
}

@end
