//
//  RootViewController.h
//  HelloMapKitWorld
//
//  Created by Hunter Hillegas on 5/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class FLLocationDownloader;

@interface RootViewController : UITableViewController <NSFetchedResultsControllerDelegate> {

}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSOperationQueue *networkQueue;
@property (nonatomic, retain) FLLocationDownloader *locationDownloader;

@end
