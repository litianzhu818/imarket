//
//  CXYBaseViewController.m
//  IMarket
//
//  Created by iMac on 14-8-28.
//  Copyright (c) 2014年 ___cxy___. All rights reserved.
//

#import "CXYBaseViewController.h"

@interface CXYBaseViewController ()

@end

@implementation CXYBaseViewController

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
     self.navigationController.navigationBarHidden = YES;
    _navigationBarHidden = NO;
    [self initNavigationBar];
}


//
- (void)viewWillAppear:(BOOL)animated
{
    //
    [super viewWillAppear:animated];

    if (_navigationBarHidden) {
        _navigaionBarView.hidden = YES;
    } else {
        _navigaionBarView.hidden = NO;
    }
    //
    
    
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
    self.view.clipsToBounds = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}
//

//
- (void)initNavigationBar
{
    // Navigation bar view
    _navigaionBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, kScreen_Width, 64)];
    _navigaionBarView.image = [UIImage imageNamed:@"IAxTitleBarBg1.png"];
    _navigaionBarView.userInteractionEnabled = YES;
    
    // Navigation title view
    navigationTitleView = [[UILabel alloc] initWithFrame:CGRectMake((kScreen_Width-200)/2, 0, 200, StaNavHeight)];
    navigationTitleView.backgroundColor = [UIColor clearColor];
    navigationTitleView.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.0];
    
        navigationTitleView.textAlignment = NSTextAlignmentCenter;
    
    // Back button
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(10, 10, 32, 60)];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backButton setBackgroundColor:[UIColor clearColor]];
    
    _nowplayingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nowplayingButton setFrame:CGRectMake(kScreen_Width - 41, 16, 31, 31)];
    [_nowplayingButton setBackgroundColor:[UIColor clearColor]];

    //
    [_navigaionBarView addSubview:backButton];
    [_navigaionBarView addSubview:_nowplayingButton];
    [self.view addSubview:_navigaionBarView];
}


//
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark -- Setter Methods
//
- (void)setNavigationBarTitle:(NSString *)navigationBarTitle
{
    if (self.hiddenBarTitle) {
        return;
    }
    navigationTitleView.text = navigationBarTitle;
    [_navigaionBarView addSubview:navigationTitleView];
}


#pragma mark -
#pragma mark -- Selector Methods
//
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark -- Public Methods
//
- (void)setNavigationBarTitleLabel:(UILabel *)titleLabel
{
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    titleLabel.frame = CGRectMake(100, 33, 120, 20);
    [_navigaionBarView addSubview:titleLabel];
}


//
- (void)setNavigationBarBackgroundImage:(NSString*)image
{
    _navigaionBarView.image = [UIImage imageNamed:image];
}


//
- (void)setNavigationBarLeftButtonImage:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    backButton.frame = CGRectMake(10, 16, 41,31);
    [backButton setBackgroundImage:image forState:UIControlStateNormal];
}


//
- (void)setNavigationBarRightButtonImage:(NSString *)image
{
    [_nowplayingButton setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
}


//
- (void)setBackgroundImageView:(NSString *)image
{
    
}



#pragma mark - remoteControl

- (BOOL)canBecomeFirstResponder

{
    return YES;
}

@end
