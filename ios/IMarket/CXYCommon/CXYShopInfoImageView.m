//
//  IAShopInfoImageView.m
//  ipoca
//
//  Created by cxy on 13-10-8.
//  Copyright (c) 2013年 monstar. All rights reserved.
//

#import "CXYShopInfoImageView.h"


#define ShopInfoFontSize 11
@implementation CXYShopInfoImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
      
    }
    return self;
}

- (void)initView
{
    self.userInteractionEnabled = YES;
    self.clipsToBounds = NO;
    self.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 20)];
    titleLable.backgroundColor = [UIColor colorWithRed:232/255.0 green:229/255.0 blue:226/255.0 alpha:1];
    titleLable.text = @"超市信息";
    titleLable.textAlignment = NSTextAlignmentCenter;
    [self  addSubview:titleLable];
    
    
    ////////////////////
    _addressTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 25, 55, 15)];
    _addressTitle.backgroundColor = [UIColor colorWithRed:232/255.0 green:229/255.0 blue:226/255.0 alpha:1];
    _addressTitle.font = [UIFont systemFontOfSize:ShopInfoFontSize];
    _addressTitle.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_addressTitle];
    
    _addressLabel = [[IACXYUnderLineLabel alloc] initWithFrame:CGRectMake(70, 25, 220, 15)];
    _addressLabel.underlineColor = [UIColor grayColor];
    _addressLabel.shouldUnderLine = YES;
    _addressLabel.highlightColor = [UIColor lightGrayColor];
    _addressLabel.font = [UIFont systemFontOfSize:ShopInfoFontSize];
    [self addSubview:_addressLabel];
    
    ///////////////////
    _openTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 55, 15)];
    _openTitle.backgroundColor = [UIColor colorWithRed:232/255.0 green:229/255.0 blue:226/255.0 alpha:1];
    _openTitle.adjustsFontSizeToFitWidth = YES;
    _openTitle.textAlignment = NSTextAlignmentCenter;
    _openTitle.font = [UIFont systemFontOfSize:10];
    [self addSubview:_openTitle];
    
    _opentimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 50, 220, 15)];
    _opentimeLabel.backgroundColor = [UIColor clearColor];
    _opentimeLabel.numberOfLines = 0;
    _opentimeLabel.font = [UIFont systemFontOfSize:ShopInfoFontSize];
    [self addSubview:_opentimeLabel];
    
    ////////////////////
    _telTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 75, 55, 15)];
    _telTitle.backgroundColor = [UIColor colorWithRed:232/255.0 green:229/255.0 blue:226/255.0 alpha:1];
    _telTitle.adjustsFontSizeToFitWidth = YES;
    _telTitle.textAlignment = NSTextAlignmentCenter;
    _telTitle.font = [UIFont systemFontOfSize:ShopInfoFontSize];
    [self addSubview:_telTitle];
    
    _telLabel = [[IACXYUnderLineLabel alloc] initWithFrame:CGRectMake(70, 75, 220, 15)];
    _telLabel.underlineColor = [UIColor grayColor];
    _telLabel.shouldUnderLine = YES;
    _telLabel.adjustsFontSizeToFitWidth = YES;
    _telLabel.highlightColor = [UIColor lightGrayColor];
    _telLabel.font = [UIFont systemFontOfSize:ShopInfoFontSize];
    [self addSubview:_telLabel];
    
    ////////////////////
    _urlTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 55, 15)];
    _urlTitle.backgroundColor = [UIColor colorWithRed:232/255.0 green:229/255.0 blue:226/255.0 alpha:1];
    _urlTitle.adjustsFontSizeToFitWidth = YES;
    _urlTitle.textAlignment = NSTextAlignmentCenter;
    _urlTitle.font = [UIFont systemFontOfSize:ShopInfoFontSize];
    [self addSubview:_urlTitle];
    
    _urlLabel = [[IACXYUnderLineLabel alloc] initWithFrame:CGRectMake(70, 100, 220, 15)];
    _urlLabel.underlineColor = [UIColor grayColor];
    _urlLabel.shouldUnderLine = YES;
    _urlLabel.font = [UIFont systemFontOfSize:ShopInfoFontSize];
    _urlLabel.highlightColor = [UIColor lightGrayColor];
    [self addSubview:_urlLabel];
}

/*
 *vcIndex:
  0:DetailViewController
  1:ShopCenterViewController
  2:ShopViewController
 */
-(void)configShopInfoView:(NSDictionary*)dic
{
   
    _addressTitle.text  = @"地址";
    _openTitle.text     = @"营业时间";
    _urlTitle.text      = @"URL";
    _telTitle.text      = @"电话";
    _addressLabel.text  = [dic objectForKey:@"address"];
    _opentimeLabel.text = [dic objectForKey:@"open_hours"];
    _urlLabel.text      = [dic objectForKey:@"url"];
    _telLabel.text      = [dic objectForKey:@"tel"];
    
    if ([_opentimeLabel.text isEqualToString:@""]) {
        _opentimeLabel.text = @" ";
    }
    [_opentimeLabel sizeToFit];
    
    
    CGRect rect     = _telTitle.frame;
    rect.origin.y   = _opentimeLabel.frame.origin.y + _opentimeLabel.frame.size.height + 10;
    _telTitle.frame = rect;
    
    rect = _telLabel.frame;
    rect.origin.y   = _opentimeLabel.frame.origin.y + _opentimeLabel.frame.size.height + 10;
    _telLabel.frame = rect;
    
    rect = _urlTitle.frame;
    rect.origin.y   = _telTitle.frame.origin.y + _telTitle.frame.size.height + 10;
    _urlTitle.frame = rect;
    
    rect = _urlLabel.frame;
    rect.origin.y   = _telTitle.frame.origin.y + _telTitle.frame.size.height + 10;
    _urlLabel.frame = rect;
    
    rect = self.frame;
    rect.size.height = _telTitle.frame.origin.y + _telTitle.frame.size.height + 10 + (_urlLabel.frame.size.height==0?(-10):_urlLabel.frame.size.height) + 10;
    self.frame = rect;
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
