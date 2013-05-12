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

@interface MSCShared : NSObject
{
    @private
    NSManagedObjectContext*         _context;
    NSManagedObjectModel*           _model;
    NSPersistentStoreCoordinator*   _store;
}

@property Root* root;
@property MSCRuby* ruby;
@property MSCTransmissionClient* transmission;

- (id)initWithContext:(NSManagedObjectContext*)ctx
             andModel:(NSManagedObjectModel*)mdl
             andStore:(NSPersistentStoreCoordinator*)str;

- (NSManagedObjectContext*) context;
- (NSManagedObjectModel*) model;
- (NSPersistentStoreCoordinator*) store;

// core data helpers
- (NSEntityDescription*) entityDescription: (NSString*)name;
- (id)insertEntity: (NSString*)name;

@end
