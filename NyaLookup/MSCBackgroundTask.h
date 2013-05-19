//
//  MSCBackgroundTask.h
//  NyaLookup
//
//  Created by Никита Б. Зуев on 19.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSCBackgroundTask : NSObject

@property NSString* taskID;

- (bool) shouldStop;
- (void) stop;

@end
