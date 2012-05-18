//
//  RootViewController.h
//  HelloMapKitWorld
//
//  Created by Hunter Hillegas on 5/29/11.
//  Copyright 2011 Hunter Hillegas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class FLLocationDownloader;

@interface RootViewController : UITableViewController <NSFetchedResultsControllerDelegate> {

}

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSOperationQueue *networkQueue;
@property (nonatomic, strong) FLLocationDownloader *locationDownloader;

@end
