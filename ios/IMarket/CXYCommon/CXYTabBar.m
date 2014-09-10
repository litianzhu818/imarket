//
//  CXYTabBar.m
//  ipoca
//
//  Created by Frcc on 13-9-17.
//  Copyright (c) 2013年 monstar. All rights reserved.
//

#import "CXYTabBar.h"
#import "CXYTitleBar.h"

#define kDuration 30.0    //supersonic wave dration time
#define kAlertDuration 5.0 //5s

@interface CXYTabBar (){
    IBOutlet UIImageView *tabbutton1Icon;
    IBOutlet UIImageView *tabbutton1Redline;
    IBOutlet UILabel *tabbutton1Title;
    
    IBOutlet UIImageView *tabbutton2Icon;
    IBOutlet UIImageView *tabbutton2Redline;
    IBOutlet UILabel *tabbutton2Title;
    
    IBOutlet UIImageView *tabbutton3Icon;
    IBOutlet UIImageView *tabbutton3Redline;
    IBOutlet UILabel *tabbutton3Title;
    
    int defaultIndex;
    
    IBOutlet UIView *displayMainView;
    UINavigationController *displayView;
    
    IBOutlet UIView *tabBar;
    
    BOOL iaHide;
    
}

@end

static UIAlertView *alv=nil;
@implementation CXYTabBar

- (void)viewDidLoad{
    self.view.backgroundColor = IABackground;
    defaultIndex = 1;
    displayView = [self.tabViews objectAtIndex:0];
    CGRect mrect = displayMainView.frame;
    mrect.origin.y = 0;
    displayView.view.frame = mrect;
    [displayMainView addSubview:[displayView view]];
    
    CGRect rect = [CXYTitleBar getInstance].view.frame;
    rect.origin.x = 0;
    rect.origin.y = 20;
    rect.size.width = 320;
    rect.size.height = 44;
    [CXYTitleBar getInstance].view.frame = rect;
    
    [self.view addSubview:[CXYTitleBar getInstance].view];
    
     __weak  typeof(UINavigationController*) weakNavMarketList = (UINavigationController*)[CXYAppDelegate sharedAppDelegate].navMarketList;
    __weak  typeof(self) weakSelf = self;
    [[CXYTitleBar getInstance] addTurnBackListen:^{
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = weakSelf.view.frame;
            rect.origin.x = 0;
            weakSelf.view.frame = rect;
            
            CGRect rect1 = weakNavMarketList.view.frame;
            rect1.origin.x = 0;
            weakNavMarketList.view.frame = rect1;
        }];
    }];
    
    [[CXYTitleBar getInstance] addTurnLeftListen:^{
        
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = weakSelf.view.frame;
            rect.origin.x = 280;
            weakSelf.view.frame = rect;
            
            CGRect rect1 = weakNavMarketList.view.frame;
            rect1.origin.x = 280;
            weakNavMarketList.view.frame = rect1;
        }];
    }];
    
    iaHide = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(IAtabBarHide) name:@"IAtabBarHide" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(IAtabBarShow) name:@"IAtabBarShow" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animation2Icon) name:@"animation2Icon" object:nil];
}

- (void)slideBack{
    [UIView animateWithDuration:0.4 animations:^{
        CGRect rect = self.view.frame;
        rect.origin.x = 0;
        self.view.frame = rect;
    }];
}


- (void)IAtabBarHide{
    if (iaHide) {
        return;
    }
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = tabBar.frame;
        rect.origin.y += rect.size.height+1;
        tabBar.frame = rect;
    }];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = displayMainView.frame;
        rect.size.height = [UIScreen mainScreen].bounds.size.height - 20 - 44;
        displayMainView.frame = rect;
        rect.origin.y = 0;
        displayView.view.frame = rect;
    }];
    iaHide = YES;
}

- (void)IAtabBarShow{
    if (!iaHide) {
        return;
    }
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = tabBar.frame;
        rect.origin.y -= rect.size.height+1;
        tabBar.frame = rect;
    }];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = displayMainView.frame;
        rect.size.height -= 0;
        rect.size.height = [UIScreen mainScreen].bounds.size.height - 20 - 44 - 50;
        displayMainView.frame = rect;
        rect.origin.y = 0;
        displayView.view.frame = rect;
    }];
    iaHide = NO;
}

- (void)setTabButtonToNormal{
    tabbutton1Icon.image = [UIImage imageNamed:@"xtabBartitle1Normal"];
    tabbutton1Redline.hidden = YES;
    tabbutton1Title.textColor = [UIColor lightGrayColor];
    
    tabbutton2Icon.image = [UIImage imageNamed:@"xtabBar2Normal"];
    tabbutton2Redline.hidden = YES;
    tabbutton2Title.textColor = [UIColor lightGrayColor];
    
    tabbutton3Icon.image = [UIImage imageNamed:@"xtabBar3Normal"];
    tabbutton3Redline.hidden = YES;
    tabbutton3Title.textColor = [UIColor lightGrayColor];
}

- (IBAction)tabbuttonClicked:(UIButton*)sender{
    [displayView popToRootViewControllerAnimated:NO];

    if (sender.tag == defaultIndex) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isRefresh"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [self setTabButtonToNormal];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"redcolor"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (sender.tag == 1) {
        tabbutton1Icon.image = [UIImage imageNamed:@"xtabBartitle1selected"];
        tabbutton1Redline.hidden = NO;
        tabbutton1Title.textColor = [UIColor whiteColor];
    }
    if (sender.tag == 2) {
        tabbutton2Icon.image = [UIImage imageNamed:@"xtabBar2Selected.png"];
        tabbutton2Redline.hidden = NO;
        [self tabbarselectedAnimation];
        tabbutton2Title.textColor = [UIColor whiteColor];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if (sender.tag == 3) {
        tabbutton3Icon.image = [UIImage imageNamed:@"xtabBar3Selected"];
        tabbutton3Redline.hidden = NO;
        tabbutton3Title.textColor = [UIColor whiteColor];
    }
    defaultIndex = sender.tag;
    
    [displayView.view removeFromSuperview];
    displayView = nil;
    
    displayView = [self.tabViews objectAtIndex:sender.tag-1];
    CGRect mrect = displayMainView.frame;
    mrect.origin.y = 0;
    displayView.view.frame = mrect;
    [displayMainView addSubview:[displayView view]];
}

-(void)maintaining
{
    [displayView popViewControllerAnimated:YES];
}

- (void)tabbarselectedAnimation{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGRect rect = tabbutton2Redline.frame;
        rect.origin.y = -15;
        rect.size.height = 61+15;
        tabbutton2Redline.frame = rect;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                CGRect rect = tabbutton2Redline.frame;
                rect.origin.y = 0;
                rect.size.height = 61;
                tabbutton2Redline.frame = rect;
            } completion:^(BOOL finished) {
                if (finished) {
                    [UIView animateWithDuration:0.15 delay:0.01 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        CGRect rect = tabbutton2Redline.frame;
                        rect.origin.y = -8;
                        rect.size.height = 61+8;
                        tabbutton2Redline.frame = rect;
                    } completion:^(BOOL finished) {
                        if (finished) {
                            [UIView animateWithDuration:0.05 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                                CGRect rect = tabbutton2Redline.frame;
                                rect.origin.y = -1;
                                rect.size.height = 62;
                                tabbutton2Redline.frame = rect;
                            } completion:^(BOOL finished) {
                                if (finished) {
                                    
                                }
                            }];
                        }
                    }];
                }
            }];
        }
    }];
}

- (void) animation2Icon
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionAutoreverse animations:^{
        if (defaultIndex == 1) {
            tabbutton2Icon.image = [UIImage imageNamed:@"xtabBar2Selected.png"];
        }
        else
        {
           tabbutton2Icon.image = [UIImage imageNamed:@"xtabBar2Normal.png"];
        }
        tabbutton2Title.textColor = [UIColor whiteColor];
        CGRect frame = tabbutton2Icon.frame;
        frame.size.height = frame.size.height - 4;
        frame.origin.y =  frame.origin.y +4;
        tabbutton2Icon.frame = frame;
        
        
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAutoreverse animations:^{
            CGRect frame1 = tabbutton2Icon.frame;
            frame1.size.height = frame1.size.height + 4;
            frame1.origin.y =  frame1.origin.y -4;
            tabbutton2Icon.frame = frame1;
        } completion:^(BOOL finished){
            if (defaultIndex == 1) {
            tabbutton2Icon.image = [UIImage imageNamed:@"xtabBar2Normal.png"];
            }
            else
            {
                tabbutton2Icon.image = [UIImage imageNamed:@"xtabBar2Selected.png"];
            }
            tabbutton2Title.textColor = [UIColor lightGrayColor];
        }];
    }
                     completion:^(BOOL finished){
                     }
     ];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
