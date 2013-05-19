//
//  MSCBackgroundManager.h
//  NyaLookup
//
//  Created by Никита Б. Зуев on 14.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSCBackgroundTask.h"

@interface MSCBackgroundManager : NSObject
{
    @private
    NSMutableDictionary* _tasks;
}

+ (id)singleton;

- (MSCBackgroundTask*) registerTask: (NSString*) name;
- (void) stopTask: (NSString*) name;
- (BOOL) isTaskRegistered: (NSString*) name;

@end
