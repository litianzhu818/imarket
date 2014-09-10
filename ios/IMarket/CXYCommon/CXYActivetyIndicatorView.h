//
//  CXYActivetyIndicatorView.h
//  
//
//  Created by cxy on 13-9-11.
//  Copyright (c) 2013年 cxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXYActivetyIndicatorView : UIView
{
    NSTimer* timer;
    BOOL isAnimating;
   
}
@property (nonatomic,strong) UIView* dotView0,*dotView1,*dotView2;
@property (nonatomic,strong) NSArray* dotViews;
@property (nonatomic, assign) NSInteger dotIndex; //index
@property (nonatomic,assign) float duration;
@property (nonatomic,assign) float scale;
@property (nonatomic,strong) UIColor* dotAncolor;
@property (nonatomic,strong) UIColor* dotViewColor; 



-(void) startAnimating;
-(void) stopAnimating;



@end
