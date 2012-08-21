//
//  FLLocationDownloader.m
//  HelloMapKitWorld
//
//  Created by Hunter Hillegas on 5/30/11.
//  Copyright 2011 Hunter Hillegas. All rights reserved.
//

#import "FLLocationDownloader.h"
#import "FLLocation.h"

@interface FLLocationDownloader ()

@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) NSManagedObjectContext *privateContext;

@end

@implementation FLLocationDownloader

- (id)initWithOperationQueue:(NSOperationQueue *)aOperationQueue withMainThreadContext:(NSManagedObjectContext *)aMainThreadContext {
    if ((self = [super init])) {
		self.operationQueue = aOperationQueue;

        NSManagedObjectContext *__privateContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        self.privateContext = __privateContext;
        [self.privateContext setParentContext:aMainThreadContext];
    }
    return self;
}

- (void)start {	
	NSLog(@"Request Locations: %@", kAssetURL);
	
	NSURL *url = [NSURL URLWithString:kAssetURL];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            id parsedResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            id locations = [parsedResponse valueForKey:@"locations"];

            //send data to method that will create and save managed objects
            [self.privateContext performBlockAndWait:^{
                [FLLocation batchUpdateOrCreateWithArray:locations inContext:self.privateContext];
            }];
        });
    }];
}

@end
