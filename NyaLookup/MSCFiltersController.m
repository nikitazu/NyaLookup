//
//  MSCFiltersController.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 12.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "MSCFiltersController.h"
#import "NSButton+TextColor.h"

@implementation MSCFiltersController

- (id)init
{
    self = [super init];
    if (self) {
        buttonsSelectedColor = [NSColor blueColor];
        buttonsDefaultColor = [NSColor whiteColor];
    }
    return self;
}

- (IBAction)pending:(id)sender {
    NSLog(@"filter pending");
    [self updateAnimes:[self.shared.root filterPending]];
    [self selectButton:sender];
}

- (IBAction)watching:(id)sender {
    NSLog(@"filter watching");
    [self updateAnimes:[self.shared.root filterWatching]];
    [self selectButton:sender];
}

- (IBAction)complteted:(id)sender {
    NSLog(@"filter completed");
    [self updateAnimes:[self.shared.root filterCompleted]];
    [self selectButton:sender];
}

- (IBAction)onHold:(id)sender {
    NSLog(@"filter onHold");
    [self updateAnimes:[self.shared.root filterOnHold]];
    [self selectButton:sender];
}

- (IBAction)dropped:(id)sender {
    NSLog(@"filter dropped");
    [self updateAnimes:[self.shared.root filterDropped]];
    [self selectButton:sender];
}

- (void) updateAnimes: (id)animes {
    [self.main setAnimes: animes];
    [self.shared.root updateImagesFor:animes inShared:self.shared];
}

- (void)selectButton:(NSButton*)button {
    [pendingButton setTextColor:buttonsDefaultColor];
    [watchingButton setTextColor:buttonsDefaultColor];
    [completedButton setTextColor:buttonsDefaultColor];
    [onHoldButton setTextColor:buttonsDefaultColor];
    [droppedButton setTextColor:buttonsDefaultColor];
    [button setTextColor:buttonsSelectedColor];
    
    
    pendingButton.state = 0;
    watchingButton.state = 0;
    completedButton.state = 0;
    onHoldButton.state = 0;
    droppedButton.state = 0;
    button.state = 1;
}

@end
