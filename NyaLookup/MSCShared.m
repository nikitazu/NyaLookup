//
//  MSCShared.m
//  NyaLookup
//
//  Created by Никита Б. Зуев on 12.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import "MSCShared.h"

@implementation MSCShared

@synthesize root;

- (id)initWithContext:(NSManagedObjectContext*)ctx
             andModel:(NSManagedObjectModel*)mdl
             andStore:(NSPersistentStoreCoordinator*)str
{
    self = [super init];
    if (self) {
        _context = ctx;
        _model = mdl;
        _store = str;
    }
    return self;
}

// core data access

- (NSManagedObjectContext*) context {
    return _context;
}

- (NSManagedObjectModel*) model {
    return _model;
}

- (NSPersistentStoreCoordinator*) store {
    return _store;
}

// singleton helpers

- (MSCRuby*) ruby {
    return [MSCRuby singleton];
}

- (MSCTransmissionClient*) transmission {
    return  [MSCTransmissionClient singleton];
}

// core data helpers
- (NSEntityDescription*) entityDescription: (NSString*)name {
    return [NSEntityDescription entityForName:name
                       inManagedObjectContext:_context];
}

- (id)insertEntity: (NSString*)name {
    return [NSEntityDescription insertNewObjectForEntityForName:name
                                         inManagedObjectContext:_context];
}

@end
