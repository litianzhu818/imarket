//
//  CXYCategoryViewController.h
//  IMarket
//
//  Created by iMac on 14-9-10.
//  Copyright (c) 2014年 ___cxy___. All rights reserved.
//
typedef NS_ENUM(NSInteger,CATEGORYTYPE)
{
    GOODSTYPE,
    MARKETTYPE
};

#import "CXYBaseViewController.h"

@interface CXYCategoryViewController : CXYBaseViewController
@property (nonatomic,assign)CATEGORYTYPE categoryType;
@end
