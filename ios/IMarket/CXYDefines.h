//
//  CXYDefines.h
//  IMarket
//
//  Created by iMac on 14-8-27.
//  Copyright (c) 2014年 ___cxy___. All rights reserved.
//

#ifndef IMarket_CXYDefines_h
#define IMarket_CXYDefines_h

#import "CXYBaseViewController.h"
#import "CXYTabBar.h"
#import "CXYTitleBar.h"
#import "CXYShopInfoImageView.h"
#import "CXYUnderLineLabel.h"
#import "CXYpageControl.h"
#import "RTLabel.h"
#import "CXYAppDelegate.h"
#import "CXYAsynImageBtn.h"
#import "CXYUnderLineLabel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CXYPersonalizeViewController.h"
#import "CXYDetailViewController.h"
#import "CXYFollowViewController.h"
#import "CXYRecordViewController.h"
#import "CXYProfileViewController.h"
#import "CXYAppDelegate+Common.h"
#import "IACXYpageControl.h"
#import "CXYMarketListViewController.h"
#import "CXYCustomAnimation.h"
#import "CXYMarketTopViewController.h"
#import "CXYSearchViewController.h"
#import "CXYCategoryViewController.h"


//常用宏定义整理


#define StaNavHeight 64
#define TabbarHeight 44
#define IABackground [UIColor colorWithRed:240/255.0 green:238/255.0 blue:238/255.0 alpha:1.00f]

#define kScreen_Height   ([UIScreen mainScreen].bounds.size.height)
#define kScreen_Width    ([UIScreen mainScreen].bounds.size.width)

#define RTText(shopName,name) [NSString stringWithFormat:@"<font face='Helvetica-Bold' size=10 color=black>%@\n</font><font face='Helvetica' size=10 color=black>%@</font>",shopName,name]

//------------------------------------Debug/Release
#ifdef DEBUG
//Debug模式
//...


#else
//发布模式
//...

//屏蔽NSLog
#define NSLog(...) {};

#endif


//------------------------------------Simulator/Device
//区分模拟器和真机
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

//------------------------------------ARC/no RAC
//ARC
#if __has_feature(objc_arc)
//compiling with ARC
#else
// compiling without ARC
#endif

//color
#define RGB(r, g, b)             [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define RGBAlpha(r, g, b, a)     [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]

#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define HexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]
#endif
