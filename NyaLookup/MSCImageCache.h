//
//  MSCImageCache.h
//  NyaLookup
//
//  Created by Никита Б. Зуев on 14.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSCPreferences.h"

@interface MSCImageCache : NSObject

+ (id) singleton;
- (NSString*) cacheImage:(NSString*)url;

@end
