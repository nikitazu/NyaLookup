//
//  Root+Caching.h
//  NyaLookup
//
//  Created by Никита Б. Зуев on 14.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "Root.h"
#import "ImageCache.h"
#import "Anime.h"
#import "MSCShared.h"

@interface Root (Caching)

- (ImageCache*) findCacheFor: (Anime*)anime;

- (void) updateImagesFor:(NSArray*)animes
                inShared:(MSCShared*)shared
          withFilterName:(NSString*)filterName;

- (void) updateImageFor:(Anime*)anime inShared: (MSCShared*)shared;

@end
