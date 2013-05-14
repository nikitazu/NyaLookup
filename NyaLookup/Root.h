//
//  Root.h
//  NyaLookup
//
//  Created by Никита Б. Зуев on 12.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Anime;
@class ImageCache;

@interface Root : NSManagedObject

@property (nonatomic, retain) NSNumber * v;
@property (nonatomic, retain) NSSet *animes;
@property (nonatomic, retain) NSSet *imageCaches;
@end

@interface Root (CoreDataGeneratedAccessors)

- (void)addAnimesObject:(Anime *)value;
- (void)removeAnimesObject:(Anime *)value;
- (void)addAnimes:(NSSet *)values;
- (void)removeAnimes:(NSSet *)values;

- (void)addImageCachesObject:(ImageCache *)value;
- (void)removeImageCachesObject:(ImageCache *)value;
- (void)addImageCaches:(NSSet *)values;
- (void)removeImageCaches:(NSSet *)values;

@end
