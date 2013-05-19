//
//  MSCBackgroundTask.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 19.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "MSCBackgroundTask.h"
#import "MSCBackgroundManager.h"

@implementation MSCBackgroundTask

@synthesize taskID;

- (bool) shouldStop {
    bool isRegistered = [[MSCBackgroundManager singleton] isTaskRegistered:self.taskID];
    if (!isRegistered) {
        NSLog(@"task %@ should stop", self.taskID);
        return YES;
    } else {
        return NO;
    }
}

- (void) stop {
    [[MSCBackgroundManager singleton] stopTask:self.taskID];
}

@end
