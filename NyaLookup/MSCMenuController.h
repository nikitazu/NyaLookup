//
//  MSCMenuController.h
//  NyaLookup
//
//  Created by Никита Б. Зуев on 12.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSCShared.h"
#import "MSCAnime.h"
#import "Anime.h"
#import "Anime+Compatibility.h"

@interface MSCMenuController : NSObject

@property MSCShared* shared;

- (IBAction)importWatching:(id)sender;
- (IBAction)importCompleted:(id)sender;
- (IBAction)clearAll:(id)sender;

@end
