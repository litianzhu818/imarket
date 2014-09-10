//
//  IASplashViewController.m
//  ipoca
//
//  Created by cxy on 13-9-27.
//  Copyright (c) 2013年 monstar. All rights reserved.
//

#import "CXYSplashViewController.h"

@interface CXYSplashViewController ()

@end

@implementation CXYSplashViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    [self performSelector:@selector(nearlyAnimation) withObject:self afterDelay:0.5];
    
	// Do any additional setup after loading the view.
}
-(void) nearlyAnimation
{
    [self performSelector:@selector(finishSplash) withObject:self afterDelay:0.8];
}
-(void) finishSplash
{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
