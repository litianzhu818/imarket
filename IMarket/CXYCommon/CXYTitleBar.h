//
//  IAxTitleBar.h
//  ipoca
//
//  Created by Frcc on 13-9-17.
//  Copyright (c) 2013年 monstar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXYTitleBar : UIViewController

@property (nonatomic) BOOL IAXHide;

+ (CXYTitleBar*)getInstance;
- (void)addTurnLeftListen:(void(^)())turn;
- (void)addTurnBackListen:(void(^)())turn;

- (void)setMaxPower:(int)max currentPower:(int)current;
- (void)setBouns:(int)bonus maxPower:(int)max currentPower:(int)current;
- (void)addPower:(int)power;

- (IBAction)turnButtonClicked:(UIButton*)sender;

@end
