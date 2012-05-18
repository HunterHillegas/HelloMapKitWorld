//
//  FLLocationDownloader.h
//  HelloMapKitWorld
//
//  Created by Hunter Hillegas on 5/30/11.
//  Copyright 2011 Hunter Hillegas. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ASIHTTPRequest.h"

@interface FLLocationDownloader : NSObject {
    NSOperationQueue *operationQueue;
    NSPersistentStoreCoordinator *storeCoordinator;
	NSManagedObjectContext *mainThreadContext;
}

@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) NSPersistentStoreCoordinator *storeCoordinator;
@property (nonatomic, strong) NSManagedObjectContext *mainThreadContext;

- (id)initWithOperationQueue:(NSOperationQueue *)aOperationQueue withStoreCoordinator:(NSPersistentStoreCoordinator *)aCoordinator withMainThreadContext:(NSManagedObjectContext *)aMainThreadContext;

- (void)start;

- (void)requestFinished:(ASIHTTPRequest *)request;
- (void)requestFailed:(ASIHTTPRequest *)request;
- (void)parseResponse:(ASIHTTPRequest *)completedRequest;

@end
