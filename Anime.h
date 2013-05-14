//
//  Anime.h
//  NyaLookup
//
//  Created by Никита Б. Зуев on 12.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Root, Watch;

@interface Anime : NSManagedObject

@property (nonatomic, retain) NSNumber * airing;
@property (nonatomic, retain) NSString * imageUrl;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSNumber * score;
@property (nonatomic, retain) NSNumber * series;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) Root *root;
@property (nonatomic, retain) NSSet *watches;
@property (nonatomic, retain) Watch *lastWatch;

// compatibility

@property NSString* status;
@property NSColor* statusColor;

// end

@end

@interface Anime (CoreDataGeneratedAccessors)

- (void)addWatchesObject:(Watch *)value;
- (void)removeWatchesObject:(Watch *)value;
- (void)addWatches:(NSSet *)values;
- (void)removeWatches:(NSSet *)values;

@end
