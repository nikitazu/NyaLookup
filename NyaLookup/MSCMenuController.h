//
//  MSCMenuController.h
//  NyaLookup
//
//  Created by Никита Б. Зуев on 12.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSCController.h"
#import "MSCAnime.h"
#import "Anime.h"
#import "Anime+Compatibility.h"

@interface MSCMenuController : MSCController

- (IBAction)importPending:(id)sender;
- (IBAction)importWatching:(id)sender;
- (IBAction)importCompleted:(id)sender;
- (IBAction)importOnHold:(id)sender;
- (IBAction)importDropped:(id)sender;
- (IBAction)clearAll:(id)sender;

@end
