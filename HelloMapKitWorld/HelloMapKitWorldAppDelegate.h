//
//  HelloMapKitWorldAppDelegate.h
//  HelloMapKitWorld
//
//  Created by Hunter Hillegas on 5/29/11.
//  Copyright 2011 Hunter Hillegas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelloMapKitWorldAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain, readonly) NSOperationQueue *networkQueue;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
