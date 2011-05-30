//
//  FLLocation.h
//  HelloMapKitWorld
//
//  Created by Hunter Hillegas on 5/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FLLocation : NSManagedObject {
@private
}
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * name;

@end
