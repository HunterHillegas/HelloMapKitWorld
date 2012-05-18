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

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) IBOutlet UINavigationController *navigationController;
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong, readonly) NSOperationQueue *networkQueue;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
