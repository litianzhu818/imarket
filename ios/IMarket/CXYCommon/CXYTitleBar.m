//
//  IAxTitleBar.m
//  ipoca
//
//  Created by Frcc on 13-9-17.
//  Copyright (c) 2013年 monstar. All rights reserved.
//

#import "CXYTitleBar.h"
#import "CXYTabBar.h"

#define kProgresslong 178
@interface CXYTitleBar (){
    void (^turnLeft) ();
    void (^turnBack) ();
    
    IBOutlet UILabel *label;
    IBOutlet UIImageView *buttonImg;
    IBOutlet UIImageView *progressImg;
    IBOutlet UIImageView *progressBGImg;
    int t;
    
    int maxPower;
    int currentPower;
    int lastCurrentPower;
    
    IBOutlet UIImageView *blasImg;
    IBOutlet UILabel *blasLabel;
    
    IBOutlet UIView *bounsView;
    IBOutlet UILabel *bounsLabel;
    IBOutlet UIImageView *bounsBGIMG;
    IBOutlet UIButton *homeBtn;
    IBOutlet UIButton *followBtn;
    int showTHenHide;

}

@end

#define progress

@implementation CXYTitleBar

+ (CXYTitleBar*)getInstance{
    static CXYTitleBar *instance = nil;
    static dispatch_once_t onceQueue;
    dispatch_once(&onceQueue, ^{ instance = [[CXYTitleBar alloc] init]; });
    return instance;
}

- (void)viewDidLoad{
    t = 0;
    maxPower = [[[NSUserDefaults standardUserDefaults] objectForKey:@"maxPower"] intValue];
    if (maxPower == 0) {
        maxPower = 1;
    }
    currentPower = [[[NSUserDefaults standardUserDefaults] objectForKey:@"currentPower"] intValue];
    label.text = [NSString stringWithFormat:@"%d",currentPower];
    CGRect rect = progressImg.frame;
    rect.size.width = 150;kProgresslong/*progresslong*/*((CGFloat)currentPower/(CGFloat)maxPower);
    progressImg.frame = rect;
    
    blasImg.alpha = 0;
    blasLabel.alpha = 0;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(homeBtnAnimation) name:@"followBtnAnimation" object:nil];
    
}



- (void)walkinscFlash{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [animation setDuration:0.7];
    [animation setAutoreverses:YES];
    [animation setRepeatCount:INTMAX_MAX];
    [animation setFromValue:[NSNumber numberWithInt:1.0]];
    [animation setToValue:[NSNumber numberWithInt:0.0]];
    buttonImg.hidden = NO;
    [buttonImg.layer addAnimation:animation forKey:@"opatity-animation"];
}

- (void)numberCount{
    int curent_last = currentPower - lastCurrentPower;
    if (curent_last > 0) {
        label.text = [NSString stringWithFormat:@"%d",lastCurrentPower+t];
    }else if(curent_last < 0){
        label.text = [NSString stringWithFormat:@"%d",lastCurrentPower-t];
    }else{
        return;
    }
    t++;
    if (t > abs(currentPower - lastCurrentPower)) {
        t=0;
        if (showTHenHide == 1) {
            [self performSelector:@selector(IAHidePr) withObject:nil afterDelay:0.4];
            showTHenHide = 0;
        }
        return;
    }
    [self performSelector:@selector(numberCount) withObject:Nil afterDelay:1.0/(CGFloat)abs(currentPower - lastCurrentPower)];
}

- (void)progressNumber:(int)longs{
    [UIView animateWithDuration:1 animations:^{
        CGRect rect = progressImg.frame;
        rect.size.width = longs;
        progressImg.frame = rect;
    }completion:^(BOOL finished) {
        if (finished) {
            //[self progressNumber:198/*progresslong*/*(t/maxPower)];
        }
    }];
}

- (void)addTurnLeftListen:(void(^)())turn{
    turnLeft = [turn copy];
}

- (void)addTurnBackListen:(void(^)())turn{
    turnBack = [turn copy];
}

- (IBAction)turnButtonClicked:(UIButton*)sender{
    sender.selected = !sender.selected;
    sender.selected?turnLeft():turnBack();
}


- (void)IAHidePr{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.view.frame;
        rect.origin.y = -64;
        self.view.frame = rect;
    }];
    self.IAXHide = YES;
}

- (void)IAShowPr{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.view.frame;
        rect.origin.y = 20;
        self.view.frame = rect;
    }];
    self.IAXHide = NO;
}

- (void)addPower:(int)power{
    [self setMaxPower:maxPower currentPower:currentPower+power];
}

- (void)setMaxPower:(int)max currentPower:(int)current{
    if ((maxPower == max) && (currentPower == current)) {
        return;
    }
    if (self.IAXHide) {
        showTHenHide = 1;
    }
    maxPower = max;
    lastCurrentPower = currentPower;
    currentPower = current;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:currentPower] forKey:@"currentPower"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:maxPower] forKey:@"maxPower"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (showTHenHide == 1) {
        [self IAShowPr];
    }
    
    if (current >= max)
    {
        [self progressNumber:kProgresslong/*progresslong*/*((CGFloat)max/(CGFloat)max)];
    }
    else
    {
        [self progressNumber:kProgresslong/*progresslong*/*((CGFloat)current/(CGFloat)max)];
    }
    [self numberCount];
    
    [UIView animateWithDuration:0.2 animations:^{
        progressImg.alpha = 0;
        progressBGImg.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.2 animations:^{
                progressImg.alpha = 1;
                progressBGImg.alpha = 1;
            } completion:^(BOOL finished) {
                if (finished) {
                    [UIView animateWithDuration:0.2 animations:^{
                        progressImg.alpha = 0;
                        progressBGImg.alpha = 0;
                    } completion:^(BOOL finished) {
                        if (finished) {
                            [UIView animateWithDuration:0.2 animations:^{
                                progressImg.alpha = 1;
                                progressBGImg.alpha = 1;
                            } completion:^(BOOL finished) {
                                if (finished) {
                                    
                                }
                            }];
                        }
                    }];
                }
            }];
        }
    }];
}

- (void)setBouns:(int)bonus maxPower:(int)max currentPower:(int)current{
    if ((maxPower == max) && (currentPower == current)) {
        return;
    }
    if (self.IAXHide) {
        showTHenHide = 1;
    }
    maxPower = max;
    lastCurrentPower = currentPower;
    currentPower = current;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:currentPower] forKey:@"currentPower"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:maxPower] forKey:@"maxPower"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (showTHenHide == 1) {
        [self IAShowPr];
    }
    
    [self progressNumber:kProgresslong/*progresslong*/*((CGFloat)current/(CGFloat)max)];
    [self numberCount];
    
    [UIView animateWithDuration:0.2 animations:^{
        progressImg.alpha = 0;
        progressBGImg.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.2 animations:^{
                progressImg.alpha = 1;
                progressBGImg.alpha = 1;
            } completion:^(BOOL finished) {
                if (finished) {
                    [UIView animateWithDuration:0.2 animations:^{
                        progressImg.alpha = 0;
                        progressBGImg.alpha = 0;
                    } completion:^(BOOL finished) {
                        if (finished) {
                            [UIView animateWithDuration:0.2 animations:^{
                                progressImg.alpha = 1;
                                progressBGImg.alpha = 1;
                            } completion:^(BOOL finished) {
                                if (finished) {
                                    
                                }
                            }];
                        }
                    }];
                }
            }];
        }
    }];
}


- (IBAction)onShowNearlyMarket:(UIButton*)sender
{
    sender.selected = !sender.selected;
    __weak  typeof(UINavigationController*) weakNavMarketList = (UINavigationController*)[CXYAppDelegate sharedAppDelegate].navMarketList;
    [UIView animateWithDuration:0.3 animations:^{
        weakNavMarketList.view.frame = CGRectMake(0, sender.selected?StaNavHeight:kScreen_Height, weakNavMarketList.view.frame.size.width, weakNavMarketList.view.frame.size.height);
    }];
}

- (void)homeBtnAnimation
{
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionAutoreverse animations:^{
        followBtn.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished){
        followBtn.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
