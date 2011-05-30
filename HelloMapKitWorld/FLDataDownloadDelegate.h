//
//  FLDataDownloadDelegate.h
//  HelloMapKitWorld
//
//  Created by Hunter Hillegas on 5/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol FLDataDownloadDelegate <NSObject>

@optional - (void)parseSuccessfulWithOptions:(NSDictionary *)options;
@optional - (void)parseFailed:(NSError *)error;

@end
