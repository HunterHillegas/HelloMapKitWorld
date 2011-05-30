//
//  FLLocation.m
//  HelloMapKitWorld
//
//  Created by Hunter Hillegas on 5/30/11.
//  Copyright (c) 2011 Hunter Hillegas. All rights reserved.
//

#import "FLLocation.h"

@implementation FLLocation

@dynamic latitude;
@dynamic longitude;
@dynamic name;

#pragma mark Annotation Stuff

- (CLLocationCoordinate2D)coordinate {
	CLLocationCoordinate2D coordinateOnMap;
	coordinateOnMap.latitude = [self.latitude doubleValue];
	coordinateOnMap.longitude = [self.longitude doubleValue];
	
	return coordinateOnMap;
}

- (NSString *)title {
	return self.name;
}

- (NSString *)subtitle {
	return [NSString stringWithFormat:@"%@ %@", self.latitude, self.longitude];
}

#pragma mark Core Data Stuff

+ (void)batchUpdateOrCreateWithArray:(NSArray *)contents inContext:(NSManagedObjectContext *)context {
    NSError *error;
	
	for (NSDictionary *values in contents) {
		FLLocation *locationItem = [FLLocation locationForName:[values valueForKey:@"name"] inContext:context];
		if (!locationItem) { //we are saying the names must be unique in this app
			locationItem = (FLLocation *)[NSEntityDescription insertNewObjectForEntityForName:@"FLLocation" inManagedObjectContext:context];
		}
		
        locationItem.name = [values valueForKey:@"name"];
		locationItem.latitude = [NSNumber numberWithFloat:[[values valueForKey:@"latitude"] floatValue]];
        locationItem.longitude = [NSNumber numberWithFloat:[[values valueForKey:@"longitude"] floatValue]];
        
        NSLog(@"Location: %@", locationItem);
	}
    
	if (![context save:&error])
		NSLog(@"Save Failed: %@", error);
}

+ (FLLocation *)locationForName:(NSString *)aName inContext:(NSManagedObjectContext *)context {
	NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init]; 
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"FLLocation" inManagedObjectContext:context]; 
	[fetchRequest setEntity:entity]; 
	[fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"name = %@", aName]];
	NSArray *existingItems = [context executeFetchRequest:fetchRequest error:&error]; 
	[fetchRequest release];
    
    return [existingItems lastObject];
}

@end
