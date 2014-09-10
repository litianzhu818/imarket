//
//  IACardView.m
//  ipoca
//
//  Created by monstar on 13-11-26.
//  Copyright (c) 2013年 monstar. All rights reserved.
//

#import "CXYCardView.h"
#import "CXYCardBgImage.h"
@implementation CXYCardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];

        _bgImage1 = [[CXYCardBgImage alloc]initWithFrame:CGRectMake(3, 10, 155, 155)];
        _bgImage1.tag = 1;
        [self addSubview:_bgImage1];
        
        _bgImage2 = [[CXYCardBgImage alloc]initWithFrame:CGRectMake(162, 10, 155, 155)];
        _bgImage2.tag = 2;
        [self addSubview:_bgImage2];

    }
    return self;
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
