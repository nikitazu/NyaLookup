//
//  MSCAnimeSetSearchNameController.h
//  NyaLookup
//
//  Created by Никита Б. Зуев on 12.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSCController.h"

@interface MSCAnimeEditController : MSCController
{
    IBOutlet NSObjectController* animeController;
    IBOutlet NSWindow* masterWindow;
    IBOutlet NSWindow* window;
    NSWindowController* windowController;
}

- (IBAction)showWindow:(id)sender;
- (IBAction)okClick:(id)sender;
- (IBAction)cancelClick:(id)sender;
- (IBAction)incrementSeries:(id)sender;
- (IBAction)decrementSeries:(id)sender;

@end
