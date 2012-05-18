//
//  FLLocationDownloader.m
//  HelloMapKitWorld
//
//  Created by Hunter Hillegas on 5/30/11.
//  Copyright 2011 Hunter Hillegas. All rights reserved.
//

#import "FLLocationDownloader.h"

#import "FLLocationParser.h"

@implementation FLLocationDownloader

@synthesize operationQueue;
@synthesize storeCoordinator;
@synthesize mainThreadContext;

- (id)initWithOperationQueue:(NSOperationQueue *)aOperationQueue withStoreCoordinator:(NSPersistentStoreCoordinator *)aCoordinator withMainThreadContext:(NSManagedObjectContext *)aMainThreadContext {
    if ((self = [super init])) {
		self.operationQueue = aOperationQueue;
		self.storeCoordinator = aCoordinator;
        self.mainThreadContext = aMainThreadContext;
    }
    return self;
}

- (void)start {	
	NSLog(@"Request Locations: %@", kAssetURL);
	
	NSURL *url = [NSURL URLWithString:kAssetURL];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setDelegate:self];
    
	[operationQueue addOperation:request];
}

- (void)parseResponse:(ASIHTTPRequest *)completedRequest {	
    FLLocationParser *requestParser = [[FLLocationParser alloc] initWithCoordinator:self.storeCoordinator andMainThreadContext:self.mainThreadContext];
    requestParser.completedRequest = completedRequest;
    [self.operationQueue addOperation:requestParser];
}

- (void)requestFinished:(ASIHTTPRequest *)request {
	if (request.responseStatusCode == 200) {
        [self parseResponse:request];
	} else {
		NSLog(@"%@ Download Response Code Was Not 200: %d", request.url, request.responseStatusCode);
	}
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	NSLog(@"Download Error: %@", [request error]);
}


@end
