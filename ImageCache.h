//
//  ImageCache.h
//  NyaLookup
//
//  Created by Никита Б. Зуев on 14.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Root;

@interface ImageCache : NSManagedObject

@property (nonatomic, retain) NSString * animeUrl;
@property (nonatomic, retain) NSString * imageUrl;
@property (nonatomic, retain) NSString * fileUrl;
@property (nonatomic, retain) Root *root;

@end
