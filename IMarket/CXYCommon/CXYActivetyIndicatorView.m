//
//  CXYActivetyIndicatorView.m
//  indicator demo
//
//  Created by cxy on 13-9-11.
//  Copyright (c) 2013年 cxy. All rights reserved.
//

#import "CXYActivetyIndicatorView.h"

#define viewWith (self.frame.size.width)
@implementation CXYActivetyIndicatorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
      
        [self initView];
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
-(void) setDotViewColor:(UIColor *)dotViewColor
{
    _dotViewColor = dotViewColor;
}
- (void)initView
{
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = NO;
     //_dotViewColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    //_dotAncolor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];

    _dotIndex = 0;
    _duration = 0.3;
    _scale = 1.5;
    
    _dotView0 = [[UIView alloc]initWithFrame:CGRectMake(5, 5, viewWith/5, viewWith/5)];
    _dotView0.layer.masksToBounds = YES;
    _dotView0.layer.cornerRadius = 2;
    _dotView0.backgroundColor = _dotViewColor;
    [self addSubview:_dotView0];
    
    
    _dotView1 = [[UIView alloc]initWithFrame:CGRectMake(5+2*viewWith/5, 5, self.frame.size.width/5, viewWith/5)];
    _dotView1.layer.masksToBounds = YES;
    _dotView1.layer.cornerRadius = 2;
    _dotView1.backgroundColor = _dotViewColor;
    [self addSubview:_dotView1];
    
    _dotView2 = [[UIView alloc]initWithFrame:CGRectMake(5+4*viewWith/5, 5, self.frame.size.width/5, viewWith/5)];
    _dotView2.layer.masksToBounds = YES;
    _dotView2.layer.cornerRadius = 2;
     _dotView2.backgroundColor = _dotViewColor;
    [self addSubview:_dotView2];
    
    _dotViews = @[_dotView0, _dotView1, _dotView2];
    
    
}
-(void)startAnimating
{
    if (!timer) {
        timer = [NSTimer scheduledTimerWithTimeInterval:_duration target:self selector:@selector(DoAnimation) userInfo:nil repeats:YES];
        [timer fire];
    }
}
-(void) toNextPosition:(UIView*) dotView
{
    [UIView beginAnimations:nil context:nil];
    dotView.transform = CGAffineTransformMakeScale(_scale, _scale);
    dotView.backgroundColor = _dotAncolor;
    [self performSelector:@selector(delayA:) withObject:dotView afterDelay:_duration];
   [UIView commitAnimations];
}
-(void) delayA:(UIView*) dotview
{
    
    [UIView beginAnimations:nil context:nil];
    dotview.transform = CGAffineTransformMakeScale(1, 1);
    [UIView commitAnimations];
}
- (void)DoAnimation
{
    [UIView animateWithDuration:_duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        UIView *dotView = _dotViews[_dotIndex];
        [self toNextPosition:dotView];
        dotView.backgroundColor = _dotViewColor;
        _dotIndex ++;
        _dotIndex = _dotIndex > 2 ? 0 : _dotIndex;
        
    } completion:nil];
}

- (void)stopAnimating
{
    if (timer)
    {
        [timer invalidate];
        timer = nil;
    }
}

- (void)dealloc{
    if (timer)
    {
        [timer invalidate];
        timer = nil;
    }
}

@end
