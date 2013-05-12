//
//  MSCFiltersController.h
//  NyaLookup
//
//  Created by Никита Б. Зуев on 12.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSCShared.h"

@interface MSCFiltersController : NSObject

@property MSCShared* shared;

- (IBAction)pending:(id)sender;
- (IBAction)watching:(id)sender;
- (IBAction)complteted:(id)sender;
- (IBAction)onHold:(id)sender;
- (IBAction)dropped:(id)sender;

@end
