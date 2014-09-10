//
//  ParkListCell.m
//  ParkDemo
//
//  Created by monstar on 14-3-11.
//  Copyright (c) 2014年 cxy. All rights reserved.
//

#import "CXYMarketListCell.h"

@implementation CXYMarketListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _marketImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 60, 60)];
        _marketImage.layer.masksToBounds = YES;
        _marketImage.layer.cornerRadius = 60.0/2;
        _marketImage.layer.borderWidth = 1;
        _marketImage.layer.borderColor = [UIColor purpleColor].CGColor;
        [self addSubview:_marketImage];
        
        _marketName = [[UILabel alloc]initWithFrame:CGRectMake(80, 5, 240, 20)];
        _marketName.backgroundColor = [UIColor clearColor];
        _marketName.font = [UIFont boldSystemFontOfSize:18];
        [self addSubview:_marketName];
        
        _marketAddress = [[UILabel alloc]initWithFrame:CGRectMake(80, 30, 240, 20)];
        _marketAddress.backgroundColor = [UIColor clearColor];
        _marketAddress.font = [UIFont systemFontOfSize:14];
        [self addSubview:_marketAddress];
        
        _marketPrice = [[UILabel alloc]initWithFrame:CGRectMake(80, 50, 80, 20)];
        _marketPrice.backgroundColor = [UIColor clearColor];
        _marketPrice.font = [UIFont systemFontOfSize:14];
        [self addSubview:_marketPrice];

        _marketType = [[UILabel alloc]initWithFrame:CGRectMake(180, 50, 80, 20)];
        _marketType.backgroundColor = [UIColor clearColor];
        _marketType.font = [UIFont systemFontOfSize:14];
        [self addSubview:_marketType];

        _marketFree = [[UILabel alloc]initWithFrame:CGRectMake(230, 5, 80, 20)];
        _marketFree.layer.masksToBounds = YES;
        _marketFree.layer.cornerRadius = 6;
        _marketFree.textAlignment = NSTextAlignmentCenter;
        _marketFree.backgroundColor = [UIColor orangeColor];
        _marketFree.font = [UIFont systemFontOfSize:14];
        [self addSubview:_marketFree];
        
        _marketDistance = [[UILabel alloc]initWithFrame:CGRectMake(250, 53, 40, 15)];
        _marketDistance.textAlignment = NSTextAlignmentCenter;
        _marketDistance.backgroundColor = [UIColor clearColor];
        _marketDistance.font = [UIFont systemFontOfSize:12];
        [self addSubview:_marketDistance];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
