//
//  marketListCell.h
//  marketDemo
//
//  Created by monstar on 14-3-11.
//  Copyright (c) 2014年 cxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXYMarketListCell : UITableViewCell
@property (nonatomic,strong)UIImageView *marketImage;
@property (nonatomic,strong)UILabel *marketName;
@property (nonatomic,strong)UILabel *marketType;
@property (nonatomic,strong)UILabel *marketAddress;
@property (nonatomic,strong)UILabel *marketPrice;
@property (nonatomic,strong)UILabel *marketFree;
@property (nonatomic,strong)UIImageView *pinImage;
@property (nonatomic,strong)UILabel *marketDistance;
@end
