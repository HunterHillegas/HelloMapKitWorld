//
//  MapViewController.h
//  HelloMapKitWorld
//
//  Created by Hunter Hillegas on 5/30/11.
//  Copyright 2011 Hunter Hillegas. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MapViewController : UIViewController <MKMapViewDelegate> {
    
}

@property (nonatomic, strong) IBOutlet MKMapView *locationMapView;
@property (nonatomic, strong) NSArray *locations;
@property (nonatomic) NSInteger selectedIndex;

@end
