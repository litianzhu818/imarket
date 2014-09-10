//
//  CXYBaseViewController.h
//  IMarket
//
//  Created by iMac on 14-8-28.
//  Copyright (c) 2014年 ___cxy___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXYBaseViewController : UIViewController
{
    UILabel *navigationTitleView;
    UIButton *backButton;
    UIImageView *backgroundImageView;
}
@property (nonatomic, strong)  UIButton *nowplayingButton;
@property (nonatomic, strong)  UIImageView *navigaionBarView;
@property (nonatomic, assign) BOOL navigationBarHidden;
@property (nonatomic, assign) BOOL nowplayingButtonHidden;
@property (nonatomic, assign) BOOL hideBackgroundImage;

// Navigation bar title
@property (strong, nonatomic) NSString *navigationBarTitle;
// Hidden navigation bar title
@property (assign, nonatomic) BOOL hiddenBarTitle;

- (void)back;

//
- (void)setNavigationBarTitleLabel:(UILabel *)titleLabel;
//
- (void)setNavigationBarBackgroundImage:(NSString *)image;
//
- (void)setNavigationBarLeftButtonImage:(NSString *)name;
//
- (void)setNavigationBarRightButtonImage:(NSString *)image;
//
- (void)setBackgroundImageView:(NSString *)image;
@end
