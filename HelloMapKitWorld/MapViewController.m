//
//  MapViewController.m
//  HelloMapKitWorld
//
//  Created by Hunter Hillegas on 5/30/11.
//  Copyright 2011 Hunter Hillegas. All rights reserved.
//

#import "MapViewController.h"

#import "FLLocation.h"

@interface MapViewController ()

- (void)populateMapWithLocations;

@end

@implementation MapViewController

- (void)dealloc {
    self.locationMapView.delegate = nil;
    
    [self.locationMapView removeAnnotations:self.locationMapView.annotations];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Map";
    
    [self populateMapWithLocations];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)populateMapWithLocations {
    [self.locationMapView addAnnotations:self.locations];
    
    FLLocation *selectedLocation = [self.locations objectAtIndex:self.selectedIndex];
    [self.locationMapView setRegion:MKCoordinateRegionMake(selectedLocation.coordinate, MKCoordinateSpanMake(0.05, 0.05)) animated:YES];
    
    [self.locationMapView selectAnnotation:selectedLocation animated:YES];
}

#pragma mark Annotations

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {	
	if (annotation == mapView.userLocation) { //returning nil means 'use built in location view'
		return nil;
	}
	
	MKPinAnnotationView *pinAnnotation = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
    
	if (pinAnnotation == nil) {
		pinAnnotation = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"];
	} else {
		pinAnnotation.annotation = annotation;
	}
	
    pinAnnotation.canShowCallout = YES;
	pinAnnotation.pinColor = MKPinAnnotationColorRed;
	pinAnnotation.animatesDrop = YES;
	
	return pinAnnotation;
}
 
@end
