//
//  ImageCache+Checks.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 14.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "ImageCache+Checks.h"

@implementation ImageCache (Checks)

- (bool) fileExists {
    return self.fileUrl != nil &&
        [[NSFileManager defaultManager] fileExistsAtPath:self.fileUrl];
}

@end
