//
//  FLLocationDownloader.h
//  HelloMapKitWorld
//
//  Created by Hunter Hillegas on 5/30/11.
//  Copyright 2011 Hunter Hillegas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLLocationDownloader : NSObject

- (id)initWithOperationQueue:(NSOperationQueue *)aOperationQueue withMainThreadContext:(NSManagedObjectContext *)aMainThreadContext;

- (void)start;

@end
