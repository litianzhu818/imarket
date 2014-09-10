//
//  CXYAppDelegate.h
//  IMarket
//
//  Created by iMac on 14-8-27.
//  Copyright (c) 2014年 ___cxy___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXYProfileViewController.h"
#import "CXYMarketListViewController.h"
@interface CXYAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navMarketList;
@property (strong, nonatomic) CXYTabBar *viewController;
@property (strong, nonatomic) CXYProfileViewController *profileVC;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (void)loginSuccess;
@end
