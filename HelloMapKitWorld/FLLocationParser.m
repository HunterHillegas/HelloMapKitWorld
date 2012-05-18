//
//  FLLocationParser.m
//  HelloMapKitWorld
//
//  Created by Hunter Hillegas on 5/30/11.
//  Copyright 2011 Hunter Hillegas. All rights reserved.
//

#import "FLLocationParser.h"
#import "FLLocation.h"

#import "ASIHTTPRequest.h"
#import "JSONKit.h"

@implementation FLLocationParser

@synthesize storeCoordinator;
@synthesize context;
@synthesize mainThreadContext;
@synthesize options;
@synthesize completedRequest;
@synthesize completionDelegate;

- (id)initWithCoordinator:(NSPersistentStoreCoordinator *)aCoordinator andMainThreadContext:(NSManagedObjectContext *)theMainThreadContext {
    return [self initWithCoordinator:aCoordinator andMainThreadContext:theMainThreadContext withDelegate:nil];
}

- (id)initWithCoordinator:(NSPersistentStoreCoordinator *)aCoordinator andMainThreadContext:(NSManagedObjectContext *)theMainThreadContext withDelegate:(id)aCompletionDelegate {
    if ((self = [super init])) {
		self.storeCoordinator = aCoordinator;
        self.mainThreadContext = theMainThreadContext;
        self.completionDelegate = aCompletionDelegate;        
    }
    return self;
}

- (void)mergeContextChangesForNotification:(NSNotification *)notification {
    if (![NSThread isMainThread]) { //the main thread moc needs to have it's methods called on the main thread
		[self performSelectorOnMainThread:@selector(mergeContextChangesForNotification:) withObject:notification waitUntilDone:YES];
		return;
	}
    
    if (self.mainThreadContext) {
    	NSLog(@"Merging Changes From Background MOC (%@) to Main Thread MOC (%@)", self.context, self.mainThreadContext);
        NSLog(@"Inserted: %d Updated: %d Deleted: %d", [[[notification userInfo] valueForKey:NSInsertedObjectsKey] count], [[[notification userInfo] valueForKey:NSUpdatedObjectsKey] count], [[[notification userInfo] valueForKey:NSDeletedObjectsKey] count]);
        
        [self.mainThreadContext mergeChangesFromContextDidSaveNotification:notification];    
    }
}

- (void)main {
	@autoreleasepool { //anything running in a background thread needs its own autorelease pool
    
    //create managed object context to handle this data
        NSManagedObjectContext *_context = [[NSManagedObjectContext alloc] init];
        self.context = _context;
        
	[context setPersistentStoreCoordinator:self.storeCoordinator];
	[context setUndoManager:nil];
	[context setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy]; //merge by property, use in-memory over store if in conflict

        //register for save notifications to push changes to main thread / UI
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mergeContextChangesForNotification:) name:NSManagedObjectContextDidSaveNotification object:self.context];
        
        //parse JSON
        NSError *parseError;
        JSONDecoder *decoder = [JSONDecoder decoder];
        id parsedResponse = [decoder objectWithData:[[self.completedRequest responseString] dataUsingEncoding:NSUTF8StringEncoding] error:&parseError];
        id locations = [parsedResponse valueForKey:@"locations"];
        
        //send data to method that will create and save managed objects
        [FLLocation batchUpdateOrCreateWithArray:locations inContext:self.context];
        
        //send message to delegate, if it resonds to message
	if ([self.completionDelegate respondsToSelector:@selector(parseSuccessfulWithOptions:)]) {
		[(NSObject *)self.completionDelegate performSelectorOnMainThread:@selector(parseSuccessfulWithOptions:) withObject:nil waitUntilDone:NO];
	} else {
		NSLog(@"Delegate Does Not Respond to parseSuccessfulWithOptions: Selector");
	}
        
	} //drain the autorelease pool
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:nil]; //it is important to remove notification observers to prevent messaging dellaoc'd objects
    
    completionDelegate = nil;
    
	
}

@end
