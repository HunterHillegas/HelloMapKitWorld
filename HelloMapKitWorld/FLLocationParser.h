//
//  FLLocationParser.h
//  HelloMapKitWorld
//
//  Created by Hunter Hillegas on 5/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLDataDownloadDelegate.h"

@class ASIHTTPRequest;

@interface FLLocationParser : NSOperation {
    NSPersistentStoreCoordinator *storeCoordinator;
    NSManagedObjectContext *context;
    NSManagedObjectContext *mainThreadContext;
    
    NSDictionary *options;
    ASIHTTPRequest *completedRequest;
    
    id completionDelegate;
}

@property (nonatomic, retain) NSPersistentStoreCoordinator *storeCoordinator;
@property (nonatomic, retain) NSManagedObjectContext *context;
@property (nonatomic, retain) NSManagedObjectContext *mainThreadContext;
@property (nonatomic, retain) NSDictionary *options;
@property (nonatomic, retain) ASIHTTPRequest *completedRequest;
@property (nonatomic, assign) id<FLDataDownloadDelegate> completionDelegate;

- (id)initWithCoordinator:(NSPersistentStoreCoordinator *)aCoordinator andMainThreadContext:(NSManagedObjectContext *)theMainThreadContext;
- (id)initWithCoordinator:(NSPersistentStoreCoordinator *)aCoordinator andMainThreadContext:(NSManagedObjectContext *)theMainThreadContext withDelegate:(id)aCompletionDelegate;

- (void)mergeContextChangesForNotification:(NSNotification *)notification;

@end
