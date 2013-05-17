//
//  MSCFiltersController.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 12.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "MSCFiltersController.h"
#import "NSButton+TextColor.h"
#import "NSButton+DrawingIcons.h"

@implementation MSCFiltersController

- (id)init
{
    self = [super init];
    if (self) {
        buttonsSelectedColor = [NSColor blackColor];
        buttonsDefaultColor = [NSColor whiteColor];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self selectButton:watchingButton];
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
    
    [pendingButton setImage:nil];
    [watchingButton setImage:nil];
    [completedButton setImage:nil];
    [onHoldButton setImage:nil];
    [droppedButton setImage:nil];
    [button drawCircleWithColor:[NSColor selectedControlColor]];
    
    [[self.main window] display]; // little hack to fix drawing circle
}


@end
