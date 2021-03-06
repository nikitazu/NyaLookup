//
//  MSCController.h
//  NyaLookup
//
//  Created by Никита Б. Зуев on 14.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSCShared.h"

@interface MSCController : NSViewController

@property MSCShared* shared;

- (id)main;

- (void) logError: (NSError*)error inMethod:(NSString*)method;

@end
