//
//  TargetDetailView.h
//  ipoca
//
//  Created by monstar on 13-9-25.
//  Copyright (c) 2013年 monstar. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TargetDetailView : UIView<UIScrollViewDelegate>
{
    UIScrollView *scrollView;
    NSInteger currentPage;
    NSInteger numberOfpages;
    NSMutableArray *imageArray;
    NSTimer *timer;
    BOOL animationFinish;
    int addImageCount;
    int removeImageCount;
}

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) CGRect imageViewFrame;
@property (nonatomic, strong) NSDictionary *dictionary;
@property (nonatomic, weak) UINavigationController *navigationController;

- (void)show;
@end
