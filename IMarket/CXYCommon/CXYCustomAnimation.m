//
//  CXYCustomAnimation.m
//  IMarket
//
//  Created by iMac on 14-9-5.
//  Copyright (c) 2014年 ___cxy___. All rights reserved.
//

#import "CXYCustomAnimation.h"

@implementation CXYCustomAnimation


+ (void)willDisplayCellAnimation:(UIView*)view
{
    //1. 配置CATransform3D的内容
    CATransform3D transform;
    transform = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    transform.m34 = 1.0/ -600;
    
    
    //2. 定义view的初始状态
    view.layer.shadowColor = [[UIColor blackColor]CGColor];
    view.layer.shadowOffset = CGSizeMake(10, 10);
    view.alpha = 0;
    
    view.layer.transform = transform;
    view.layer.anchorPoint = CGPointMake(0, 0.5);
    
    //3. 定义view的最终状态，并提交动画
    [UIView beginAnimations:@"transform" context:NULL];
    [UIView setAnimationDuration:0.5];
    view.layer.transform = CATransform3DIdentity;
    view.alpha = 1;
    view.layer.shadowOffset = CGSizeMake(0, 0);
    view.frame = CGRectMake(0, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
    [UIView commitAnimations];
 
}

+ (void)followAnimation:(CXYAsynImageBtn*)imageBtn
{
    //add black view in ImageBtn
    UIImageView *tempView = [[UIImageView alloc]initWithFrame:imageBtn.bounds];
    tempView.image = [UIImage imageNamed:@"nearly_action.png"];
    tempView.alpha = 0.9;
    [imageBtn addSubview:tempView];
    [self performSelector:@selector(delayDel:) withObject:tempView afterDelay:0.7];
    
    /////////////////////////animation effect//////////////////////
    
    CALayer *theLayer = [[CALayer alloc] init];
    [CATransaction begin];  //show transaction,and modifiy many transaction's layer
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    theLayer.opacity = 0.9; //opacity
    theLayer.contents = (id)imageBtn.currentImage.CGImage;
    theLayer.frame = [[UIApplication sharedApplication].keyWindow convertRect:imageBtn.bounds fromView:imageBtn];
    [[UIApplication sharedApplication].keyWindow.layer addSublayer:theLayer];
    [CATransaction commit];
    
    //
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:theLayer.position]; //begin point
    CGPoint toPoint = CGPointMake(290, 40);//end point
    [movePath addQuadCurveToPoint:toPoint
                     controlPoint:CGPointMake(kScreen_Width/2,theLayer.position.y+200)]; //end point and control point
    
    
    //key frame
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.path = movePath.CGPath;
//    positionAnimation.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];;
    positionAnimation.removedOnCompletion = YES;
    
    //scale
    CABasicAnimation* basicA = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    basicA.fromValue = [NSNumber numberWithFloat:1];//change to id type
    basicA.byValue = [NSNumber numberWithFloat:0.3];
    basicA.toValue = [NSNumber numberWithFloat:0.1];
    
    basicA.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]; //mapping mode
    
    
    //group animation
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.beginTime = CACurrentMediaTime();
    group.duration = 0.5;
    group.animations = [NSArray arrayWithObjects:positionAnimation,basicA,nil];
    group.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    group.delegate = self;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    
    [theLayer addAnimation:group forKey:@"opacity"];
    
    [self performSelector:@selector(addFinished:) withObject:theLayer afterDelay:0.5f];
 
}

//add finish   send request
+ (void)addFinished:(CALayer*)layer{
    
    [layer removeFromSuperlayer];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"followBtnAnimation" object:nil];
}

+ (void)delayDel:(UIView*)view
{
    [view removeFromSuperview];
}
@end
