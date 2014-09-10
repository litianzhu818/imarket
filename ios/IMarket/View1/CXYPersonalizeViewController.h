//
//  HomeViewController.h
//  ipoca
//
//  Created by cxy on 13-9-16.
//  Copyright (c) 2013年 monstar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "EGORefreshTableHeaderView.h"
@interface CXYPersonalizeViewController : CXYBaseViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIAlertViewDelegate,EGORefreshTableHeaderDelegate>

@property (nonatomic,assign)BOOL isRecommended;
@end
