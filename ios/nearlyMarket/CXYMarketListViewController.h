//
//  CXYMarketListViewController.h
//  ParkDemo
//
//  Created by monstar on 14-3-11.
//  Copyright (c) 2014年 cxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface CXYMarketListViewController : CXYBaseViewController<UITableViewDataSource,UITableViewDelegate,MKMapViewDelegate,CLLocationManagerDelegate>

@end
