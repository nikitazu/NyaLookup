//
//  MSCShared.h
//  NyaLookup
//
//  Created by Никита Б. Зуев on 12.05.13.
//  Copyright (c) 2013 Никита Б. Зуев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Root.h"
#import "MSCRuby.h"
#import "MSCTransmissionClient.h"
#import "MSCImageCache.h"

@interface MSCShared : NSObject
{
    @private
    NSManagedObjectContext*         _context;
    NSManagedObjectModel*           _model;
    NSPersistentStoreCoordinator*   _store;
}

// shared state
@property Root* root;

- (id)initWithContext:(NSManagedObjectContext*)ctx
             andModel:(NSManagedObjectModel*)mdl
             andStore:(NSPersistentStoreCoordinator*)str;

- (NSManagedObjectContext*) context;
- (NSManagedObjectModel*) model;
- (NSPersistentStoreCoordinator*) store;

// singleton helpers
- (MSCRuby*)ruby;
- (MSCTransmissionClient*)transmission;

// core data helpers
- (NSEntityDescription*) entityDescription: (NSString*)name;
- (id)insertEntity: (NSString*)name;
- (bool)saveContex;

@end
