//
//  MSCFiltersController.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 12.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "MSCFiltersController.h"

@implementation MSCFiltersController

@synthesize shared;

- (IBAction)pending:(id)sender {
    NSLog(@"filter pending");
}

- (IBAction)watching:(id)sender {
    NSLog(@"filter watching");
}

- (IBAction)complteted:(id)sender {
    NSLog(@"filter complteted");
}

- (IBAction)onHold:(id)sender {
    NSLog(@"filter onHold");
}

- (IBAction)dropped:(id)sender {
    NSLog(@"filter dropped");
}

@end
