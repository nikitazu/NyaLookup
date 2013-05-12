//
//  MSCAnimeSetSearchNameController.h
//  NyaLookup
//
//  Created by Никита Б. Зуев on 12.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSCShared.h"
#import "Anime.h"

@interface MSCAnimeEditController : NSObject
{
    IBOutlet NSWindow* masterWindow;
    IBOutlet NSWindow* window;
    NSWindowController* windowController;
}

@property MSCShared* shared;

@property (retain) Anime* currentAnime;

- (IBAction)showWindow:(id)sender;
- (IBAction)okClick:(id)sender;
- (IBAction)cancelClick:(id)sender;

@end
