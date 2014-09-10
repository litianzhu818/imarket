//
//  IACardBgImage.h
//  ipoca
//
//  Created by cxy on 13-9-26.
//  Copyright (c) 2013年 monstar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXYAsynImageBtn.h"

@interface CXYCardBgImage : UIImageView

@property (nonatomic,strong)CXYAsynImageBtn* bgBtn;
@property (nonatomic,strong)UIImageView* leftImageV;
@property (nonatomic,strong)UILabel* discountLabel;
@property (nonatomic,strong)UIImageView* rightImageV;
@property (nonatomic,strong)UIButton* buyBtn;
@property (nonatomic,strong)UILabel* label;
@property (nonatomic,strong)UIButton* nearlyBtn;

@end
