//
//  CXYAppDelegate+Common.m
//  IMarket
//
//  Created by iMac on 14-8-28.
//  Copyright (c) 2014年 ___cxy___. All rights reserved.
//

#import "CXYAppDelegate+Common.h"
static CXYAppDelegate *sharedAppDelegate = nil;
@implementation CXYAppDelegate (Common)


+ (CXYAppDelegate *)sharedAppDelegate
{
    if (!sharedAppDelegate) {
        sharedAppDelegate = (CXYAppDelegate *)[UIApplication sharedApplication].delegate;
    }
    
    return sharedAppDelegate;
}
@end
