//
//  MSCImageCache.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 14.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "MSCImageCache.h"
#import "NSString+Utils.h"

@implementation MSCImageCache

+ (id)singleton
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // <-- my code here
    });
    return _sharedObject;
}

- (NSString*) cacheImage:(NSString*)url withName: (NSString*)name {
    if ([url isEmpty]) {
        NSLog(@"caching impossible url is empty");
        return nil;
    }
    
    if ([name isEmpty]) {
        NSLog(@"caching impossible name is empty");
        return nil;
    }
    
    NSLog(@"caching image %@ with name %@", url, name);
    NSString* home = NSHomeDirectory();
    NSString* cacheDir = [NSString pathWithComponents:@[home, @".NyaLookupCache"]];
    
    [[NSFileManager defaultManager] createDirectoryAtPath:cacheDir
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:nil];
    
    NSString* saneName = [self sanitizeFileNameString: name];
    NSString* saveto = [NSString pathWithComponents:@[cacheDir, saneName]];
    NSURL* uri = [NSURL URLWithString:url];
    NSData* data = [NSData dataWithContentsOfURL:uri];
    [data writeToFile:saveto atomically:YES];
    return saveto;
}

- (NSString*) sanitizeFileNameString:(NSString *)fileName {
    NSCharacterSet* illegalFileNameCharacters =
        [NSCharacterSet characterSetWithCharactersInString:@"/\\?%*|\"<>"];
    
    return [[fileName componentsSeparatedByCharactersInSet:illegalFileNameCharacters]
            componentsJoinedByString:@""];
}


@end
