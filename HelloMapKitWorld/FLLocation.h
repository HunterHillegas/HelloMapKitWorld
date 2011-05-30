//
//  FLLocation.h
//  HelloMapKitWorld
//
//  Created by Hunter Hillegas on 5/30/11.
//  Copyright (c) 2011 Hunter Hillegas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface FLLocation : NSManagedObject <MKAnnotation> {
@private
}

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * name;

+ (void)batchUpdateOrCreateWithArray:(NSArray *)contents inContext:(NSManagedObjectContext *)context;

+ (FLLocation *)locationForName:(NSString *)aName inContext:(NSManagedObjectContext *)context;

@end
