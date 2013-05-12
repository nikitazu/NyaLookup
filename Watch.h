//
//  Watch.h
//  NyaLookup
//
//  Created by Никита Б. Зуев on 12.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Anime;

@interface Watch : NSManagedObject

@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) NSDate * updated;
@property (nonatomic, retain) NSNumber * progress;
@property (nonatomic, retain) NSNumber * onHold;
@property (nonatomic, retain) NSNumber * dropped;
@property (nonatomic, retain) Anime *anime;

@end
