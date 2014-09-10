//
//  IAShopInfoImageView.h
//  ipoca
//
//  Created by cxy on 13-10-8.
//  Copyright (c) 2013年 monstar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IACXYUnderLineLabel.h"
@interface CXYShopInfoImageView : UIImageView

@property (nonatomic,strong)UILabel* addressTitle;
@property (nonatomic,strong)UILabel* urlTitle;
@property (nonatomic,strong)UILabel* telTitle;
@property (nonatomic,strong)UILabel* openTitle;


@property (nonatomic,strong)IACXYUnderLineLabel* addressLabel;
@property (nonatomic,strong)UILabel *floorLable;
@property (nonatomic,strong)IACXYUnderLineLabel* urlLabel;
@property (nonatomic,strong)IACXYUnderLineLabel* telLabel;
@property (nonatomic,strong)UILabel* opentimeLabel;

- (void)initView;
-(void)configShopInfoView:(NSDictionary*)dic;

@end
