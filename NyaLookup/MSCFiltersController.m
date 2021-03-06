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
    [self filterAnimes:[self.shared.root filterPending] withFilterName: @"pending"];
    [self selectButton:sender];
}

- (IBAction)watching:(id)sender {
    [self filterAnimes:[self.shared.root filterWatching] withFilterName: @"watching"];
    [self selectButton:sender];
}

- (IBAction)complteted:(id)sender {
    [self filterAnimes:[self.shared.root filterCompleted] withFilterName: @"completed"];
    [self selectButton:sender];
}

- (IBAction)onHold:(id)sender {
    [self filterAnimes:[self.shared.root filterOnHold] withFilterName: @"onHold"];
    [self selectButton:sender];
}

- (IBAction)dropped:(id)sender {
    [self filterAnimes:[self.shared.root filterDropped] withFilterName: @"dropped"];
    [self selectButton:sender];
}

- (void) filterAnimes: (id)animes withFilterName: (NSString*)filterName {
    NSLog(@"filter %@", filterName);
    [self.main setAnimes: animes];
    [self.shared.root updateImagesFor:animes
                             inShared:self.shared
                       withFilterName:filterName];
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
