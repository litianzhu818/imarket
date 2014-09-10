//
//  IACardBgImage.m
//  ipoca
//
//  Created by cxy on 13-9-26.
//  Copyright (c) 2013年 monstar. All rights reserved.
//

#import "CXYCardBgImage.h"

@implementation CXYCardBgImage

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //self.image = Image(@"bounds", @"png");
        self.userInteractionEnabled = YES;
        
        
        _bgBtn = [[CXYAsynImageBtn alloc]initWithFrame:[self bounds]];//CGRectMake(3, 3, self.frame.size.width-6, self.frame.size.height-6)];
        _bgBtn.backgroundColor = [UIColor whiteColor];
//        _bgBtn.layer.borderWidth = 3;
//        _bgBtn.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8].CGColor;
        [self addSubview:_bgBtn];
        
        _leftImageV = [[UIImageView alloc]init];
        _leftImageV.image = [UIImage imageNamed:@"IAprice.png"];
        _leftImageV.frame = CGRectMake(-5, 5, 60, 37);
        [self addSubview:_leftImageV];
       
        _discountLabel = [[UILabel alloc]init];
        _discountLabel.backgroundColor = [UIColor clearColor];
        _discountLabel.textColor = [UIColor whiteColor];
        _discountLabel.frame = CGRectMake(0, 0, 60, 20);
        _discountLabel.font = [UIFont systemFontOfSize:12];
        _discountLabel.textAlignment = NSTextAlignmentCenter;
        [_leftImageV addSubview:_discountLabel];
        
        _rightImageV = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width-28, 3, 25, 25)];
        self.rightImageV.image = [UIImage imageNamed:@"P.png"]; /*Image(@"P", @"png");*/
        [self addSubview:_rightImageV];
        
        _buyBtn = [[UIButton alloc]initWithFrame:CGRectMake(118, 118, 28, 28)];
        [_buyBtn setBackgroundImage:/*Image(@"nearly1",@"png")*/[UIImage imageNamed:@"nearly1.png"] forState:UIControlStateNormal];
        [_buyBtn setBackgroundImage:/*Image(@"nearly2",@"png")*/[UIImage imageNamed:@"nearly2.png"] forState:UIControlStateSelected];
        //_buyBtn.autoresizingMask = AutoSize;
        [_bgBtn addSubview:_buyBtn];
        
        _nearlyBtn = [[UIButton alloc]initWithFrame:CGRectMake(110, 98, 40, 40)];
        _nearlyBtn.backgroundColor = [UIColor clearColor];
        [self addSubview:_nearlyBtn];
        
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0,self.frame.size.height+5, self.frame.size.width, 30)];
        _label.numberOfLines = 2;
        _label.font = [UIFont systemFontOfSize:12];
        _label.backgroundColor = [UIColor clearColor];
        [self addSubview:_label];
     }
    return self;
}

-(void)dealloc
{
    while ([[self subviews] lastObject]) {
        [[[self subviews] lastObject] removeFromSuperview];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
