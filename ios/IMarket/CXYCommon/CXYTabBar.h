//
//  CXYTabBar.h
//  ipoca
//
//  Created by Frcc on 13-9-17.
//  Copyright (c) 2013年 monstar. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DATA_BUF_SIZ	402

@interface CXYTabBar : UIViewController<UIAlertViewDelegate>{
@private
	
}

@property (nonatomic,strong) NSArray *tabViews;
@property (nonatomic,strong) UIViewController *sildeView;

- (IBAction)tabbuttonClicked:(UIButton*)sender;
- (void)slideBack;

@end
