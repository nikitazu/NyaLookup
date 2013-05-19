//
//  MSCBackgroundManager.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 14.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "MSCBackgroundManager.h"

@implementation MSCBackgroundManager

+ (id)singleton
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // <-- my code here
    });
    return _sharedObject;
}

- (id)init
{
    self = [super init];
    if (self) {
        _tasks = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (MSCBackgroundTask*) registerTask: (NSString*) name {
    if ([self isTaskRegistered:name]) {
        NSLog(@"registerTask: %@ skip, task allready registered", name);
        return nil;
    }
    
    NSLog(@"registerTask: %@", name);
    [_tasks setValue:@"ok" forKey:name];
    MSCBackgroundTask* task = [[MSCBackgroundTask alloc] init];
    task.taskID = name;
    return task;
}

- (void) stopTask: (NSString*) name {
    NSLog(@"stopTask: %@", name);
    [_tasks setValue:nil forKey:name];
}

- (BOOL) isTaskRegistered: (NSString*) name {
    return [[_tasks valueForKey:name] isEqualToString:@"ok"];
}

@end
