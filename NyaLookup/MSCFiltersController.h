//
//  MSCFiltersController.h
//  NyaLookup
//
//  Created by Никита Б. Зуев on 12.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSCController.h"
#import "MSCBackgroundManager.h"
#import "Root.h"
#import "Root+AnimeFilters.h"
#import "Root+Caching.h"
#import "ImageCache.h"
#import "ImageCache+Checks.h"

@interface MSCFiltersController : MSCController
{
    NSColor* buttonsSelectedColor;
    NSColor* buttonsDefaultColor;
    
    IBOutlet NSButton* pendingButton;
    IBOutlet NSButton* watchingButton;
    IBOutlet NSButton* completedButton;
    IBOutlet NSButton* onHoldButton;
    IBOutlet NSButton* droppedButton;
}

- (IBAction)pending:(id)sender;
- (IBAction)watching:(id)sender;
- (IBAction)complteted:(id)sender;
- (IBAction)onHold:(id)sender;
- (IBAction)dropped:(id)sender;

@end
