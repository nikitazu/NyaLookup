//
//  MSCAppDelegate.h
//  NyaLookup
//
//  Created by Никита Б. Зуев on 18.02.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MSCAnime.h"

@interface MSCAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (retain) NSArray* animes;
@property (assign) IBOutlet NSArrayController* animesController;




@end
