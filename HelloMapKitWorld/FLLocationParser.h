//
//  FLLocationParser.h
//  HelloMapKitWorld
//
//  Created by Hunter Hillegas on 5/30/11.
//  Copyright 2011 Hunter Hillegas. All rights reserved.
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
    
    id __weak completionDelegate;
}

@property (nonatomic, strong) NSPersistentStoreCoordinator *storeCoordinator;
@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSManagedObjectContext *mainThreadContext;
@property (nonatomic, strong) NSDictionary *options;
@property (nonatomic, strong) ASIHTTPRequest *completedRequest;
@property (nonatomic, weak) id<FLDataDownloadDelegate> completionDelegate;

- (id)initWithCoordinator:(NSPersistentStoreCoordinator *)aCoordinator andMainThreadContext:(NSManagedObjectContext *)theMainThreadContext;
- (id)initWithCoordinator:(NSPersistentStoreCoordinator *)aCoordinator andMainThreadContext:(NSManagedObjectContext *)theMainThreadContext withDelegate:(id)aCompletionDelegate;

- (void)mergeContextChangesForNotification:(NSNotification *)notification;

@end
