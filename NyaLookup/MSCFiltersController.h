//
//  MSCFiltersController.h
//  NyaLookup
//
//  Created by Никита Б. Зуев on 12.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSCController.h"
#import "Root.h"
#import "Root+AnimeFilters.h"
#import "MSCBackgroundManager.h"

@interface MSCFiltersController : MSCController

- (IBAction)pending:(id)sender;
- (IBAction)watching:(id)sender;
- (IBAction)complteted:(id)sender;
- (IBAction)onHold:(id)sender;
- (IBAction)dropped:(id)sender;

@end
