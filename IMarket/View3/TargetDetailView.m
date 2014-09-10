//
//  TargetDetailView.m
//  ipoca
//
//  Created by monstar on 13-9-25.
//  Copyright (c) 2013年 monstar. All rights reserved.
//


#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Heiht [UIScreen mainScreen].bounds.size.height
#define DetailView_tag 100
#define DisplayView_tag 101
#define PageControlView_tag 102
#define DetailLabelView_tag 103
#define Button_tag 104
#define AnimationView_tag 105

#import "TargetDetailView.h"
#import "RTLabel.h"

#define DetailLabel_Text @"<font face='HiraKakuProN-W6' size=13 color='#211c24'>%@</font>\n<font face='HiraKakuProN-W6' size=10 color='#211c24'>%@积分</font>\n\n<font face='HiraKakuProN-W3' size=11 color='#211c24'>%@</font>"

#define kTEXT @"欧德堡超高温处理全脂牛奶礼盒装1L*6\n商品名称： 欧德堡超高温处理全脂牛奶礼盒装1L*6\n商品产地： 德国\n品 牌： 欧德堡\n净 含 量： 6*1L\n。"

@interface TargetDetailView ()

- (void)initScrollView;
- (void)initPageControlView:(UIView*)pageControlView;
- (void)updatePageIndex;
- (void)startAnimation;
- (void)closeView;
- (void)setTargetAction;
- (void)setTargetAnimation;

@end

@implementation TargetDetailView

@synthesize image;
@synthesize imageViewFrame;
@synthesize dictionary;
@synthesize navigationController;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}

- (void)show
{
    self.tag = DetailView_tag;
    numberOfpages = 4;
    currentPage = 0;
    
    UIView *_backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Heiht)];
    _backgroundView.backgroundColor = [UIColor blackColor];
    _backgroundView.alpha = 0.8;
    [self addSubview:_backgroundView];

    UIScrollView *bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(10, 65, Screen_Width - 20, Screen_Heiht -75)];
    bgScrollView.backgroundColor = [UIColor clearColor];
    [self addSubview:bgScrollView];
    
    UIView *_displayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width - 20, Screen_Heiht > 480 ? 280 :230)];
    _displayView.backgroundColor = [UIColor whiteColor];
    _displayView.tag = DisplayView_tag;
    [bgScrollView addSubview:_displayView];
    
    UIView *_pageControlView = [[UIView alloc] initWithFrame:CGRectMake(_displayView.frame.size.width - (numberOfpages + 1) * 13, 10, numberOfpages * 2 *10, 10)];
    _pageControlView.tag = PageControlView_tag;
    [self initPageControlView:_pageControlView];
    [_displayView addSubview:_pageControlView];
    
    [self updatePageIndex];
    
    UIView *_detailLabelView = [[UIView alloc] initWithFrame:CGRectMake(_displayView.frame.origin.x, _displayView.frame.origin.y + _displayView.frame.size.height, _displayView.frame.size.width, Screen_Heiht - (_displayView.frame.origin.y + _displayView.frame.size.height) - (Screen_Heiht > 480 ? 50 :10))];
    _detailLabelView.backgroundColor = IABackground;
    _detailLabelView.tag = DetailLabelView_tag;
    _detailLabelView.clipsToBounds = YES;
    [bgScrollView addSubview:_detailLabelView];

    RTLabel *_detailLabel = [[RTLabel alloc] initWithFrame:CGRectMake(10, 10, _detailLabelView.frame.size.width - 20, 50)];
    _detailLabel.text = kTEXT;
    _detailLabel.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:10.0f];
    _detailLabel.textColor = [UIColor blackColor];
    _detailLabel.backgroundColor = [UIColor clearColor];
    [_detailLabelView addSubview:_detailLabel];
    
    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, _detailLabelView.frame.size.width - 20, 20)];
    contentLabel.textColor = [UIColor blackColor];
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:11];
    contentLabel.numberOfLines = 0;
    contentLabel.text = kTEXT;
    [_detailLabelView addSubview:contentLabel];
    [contentLabel sizeToFit];
    
    CGRect rect = _detailLabelView.frame;
    rect.size.height = contentLabel.frame.origin.y + contentLabel.frame.size.height + 70;
    _detailLabelView.frame = rect;
    
    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(10, _detailLabelView.frame.size.height - 56, 280, 46);
    [_button setImage:[UIImage imageNamed:@"getTarget1.png"] forState:UIControlStateNormal];
    _button.tag = Button_tag;
    [_button addTarget:self action:@selector(setTargetAction) forControlEvents:UIControlEventTouchUpInside];
    [_detailLabelView addSubview:_button];
    
    bgScrollView.contentSize = CGSizeMake(bgScrollView.frame.size.width, _detailLabelView.frame.origin.y + _detailLabelView.frame.size.height);
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(20, (Screen_Heiht > 480 ? 75 : 50), _displayView.frame.size.width - 40, 150)];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * numberOfpages, scrollView.frame.size.height);
    scrollView.scrollEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor clearColor];
    [self initScrollView];
    [_displayView addSubview:scrollView];
    
    UIButton *_closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeButton setTitle:@"关闭" forState:UIControlStateNormal];
    _closeButton.frame = CGRectMake(Screen_Width - 57 - 10, 35, 57, 15);
    _closeButton.alpha = 1.0f;
    [self addSubview:_closeButton];
    
    UIButton *_closeButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeButton1 setBackgroundColor:[UIColor clearColor]];
    _closeButton1.frame = CGRectMake(Screen_Width - 57 - 53, 35, 100, 30);
    [_closeButton1 addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    _closeButton1.alpha = 1.0f;
    [self addSubview:_closeButton1];

    
    _displayView.hidden = YES;
    _detailLabelView.hidden = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self startAnimation];
}

- (void)initScrollView
{
    for (int i = 0; i < 4; i++)
    {
        UIImageView *_imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake(i * scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height);
//        [_imageView setImageWithURL:[NSURL URLWithString:[[[dictionary objectForKey:@"url"] objectAtIndex:i] objectForKey:@"url"]]];
        _imageView.image = [UIImage imageNamed:@"1.png"];
        _imageView.contentMode = UIViewContentModeScaleToFill;
        _imageView.tag = i + 1;
        [scrollView addSubview:_imageView];
    }
}

- (void)initPageControlView:(UIView*)pageControlView
{

    for (int i = 0; i < 4; i++)
    {
        UIImageView *_imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"page2.png"] highlightedImage:[UIImage imageNamed:@"page1.png"]];
        _imageView.frame = CGRectMake(i * 13, 0, 13, 13);
        _imageView.tag = i;
        [pageControlView addSubview:_imageView];
    }
}

- (void)updatePageIndex
{
    for (int i = 0; i < 4; i++)
    {
        if (currentPage == i)
        {
           ((UIImageView *)[[[self viewWithTag:DisplayView_tag] viewWithTag:PageControlView_tag] viewWithTag:i]).highlighted = YES;
        }
        else
        {
            ((UIImageView *)[[[self viewWithTag:DisplayView_tag] viewWithTag:PageControlView_tag] viewWithTag:i]).highlighted = NO;
        }
    }
}

- (void)donedonedoen{
    [self removeFromSuperview];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"setGiftDone" object:Nil];
}

- (void)startAnimation
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(imageViewFrame.origin.x, imageViewFrame.origin.y)];
    CGPoint toPoint = CGPointMake([scrollView convertPoint:CGPointMake([scrollView viewWithTag:1].frame.origin.x , [scrollView viewWithTag:1].frame.origin.y) toView:[UIApplication sharedApplication].keyWindow].x, [scrollView convertPoint:CGPointMake([scrollView viewWithTag:1].frame.origin.x , [scrollView viewWithTag:1].frame.origin.y) toView:[UIApplication sharedApplication].keyWindow].y);
    
    CGPoint controlPoint = CGPointMake(Screen_Width - scrollView.frame.size.width - [self viewWithTag:DisplayView_tag].frame.origin.x, 0);
    [path addQuadCurveToPoint:toPoint controlPoint:controlPoint];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
    imageView.image = image;
    imageView.tag = AnimationView_tag;
    [self addSubview:imageView];
    
    imageView.layer.anchorPoint = CGPointMake(0, 0);
    
	CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	animation.path = path.CGPath;
	animation.repeatCount = 1;
    
    CABasicAnimation *scaleAnimation  = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
	scaleAnimation.fromValue = [NSNumber numberWithFloat:imageViewFrame.size.width/scrollView.frame.size.width];
	scaleAnimation.toValue = [NSNumber numberWithFloat:1];
	
	CAAnimationGroup *group = [CAAnimationGroup animation];
	group.duration = 0.5f;
	group.animations = [NSArray arrayWithObjects: animation,scaleAnimation, nil];
    group.delegate = self;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    imageView.frame =CGRectMake(toPoint.x, toPoint.y, scrollView.frame.size.width, scrollView.frame.size.height);
    [group setValue:@"move" forKey:@"AnimationType"];

	[imageView.layer addAnimation:group forKey:@"move"];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([[anim valueForKey:@"AnimationType"] isEqualToString:@"move"])
    {
        CGRect detailLabelViewFrame = [self viewWithTag:DetailLabelView_tag].frame;
        CGRect startdetailLabelViewFrame = detailLabelViewFrame;
        detailLabelViewFrame.size.height = 0;
        [self viewWithTag:DetailLabelView_tag].frame = detailLabelViewFrame;
     
        [[self viewWithTag:DetailLabelView_tag] viewWithTag:Button_tag].alpha = 0;
        
        [self viewWithTag:DisplayView_tag].alpha = 0;
        [self viewWithTag:DisplayView_tag].hidden = NO;
        [self viewWithTag:DetailLabelView_tag].hidden = NO;
        
        [UIView animateWithDuration:0.5f animations:^{
            [self viewWithTag:DisplayView_tag].alpha = 1.0f;
        } completion:^(BOOL finished) {
            [[self viewWithTag:AnimationView_tag] removeFromSuperview];
            [UIView animateWithDuration:0.5f animations:^{
                [self viewWithTag:DetailLabelView_tag].frame = startdetailLabelViewFrame;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:1.0f animations:^{
                    [[self viewWithTag:DetailLabelView_tag] viewWithTag:Button_tag].alpha = 1.0f;
                } completion:^(BOOL finished) {
                    animationFinish = YES;
                }];
            }];
        }];
    }
    else
    {
        [(UIImageView*)[imageArray objectAtIndex:[[anim valueForKey:@"AnimationType"] intValue] - 1] removeFromSuperview];
        removeImageCount++;
        if (removeImageCount == [imageArray count])
        {
            animationFinish = YES;
            imageArray = nil;
            [timer invalidate];
            timer = nil;
            [self closeView];
            if (!navigationController) {
                [self performSelector:@selector(donedonedoen) withObject:Nil afterDelay:0];
            }else{
                [navigationController popViewControllerAnimated:YES];
                
            }

        }

    }
}

- (void)setTargetAction
{
   [self setTargetAnimation];
}

- (void)setTargetAnimation
{
    if (animationFinish)
    {
        animationFinish = NO;
        removeImageCount = 0;
        addImageCount = 0;
        imageArray = nil;
        imageArray = [[NSMutableArray alloc] init];
        [timer invalidate];
        timer = nil;
        timer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(add) userInfo:nil repeats:YES];
    }
}

- (void)add
{
    
    addImageCount++;
    if (addImageCount>30)
    {
        addImageCount = 0;
        [timer invalidate];
        timer = nil;
        return;
    }
    NSArray * array  = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"kirakira0.png"], [UIImage imageNamed:@"kirakira1.png"], nil];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kirakira.png"]];
    imageView.backgroundColor =[UIColor clearColor];
    imageView.tag = addImageCount;
    imageView.frame = CGRectMake(scrollView.frame.origin.x + (CGFloat) random()/(CGFloat) RAND_MAX * scrollView.frame.size.width, scrollView.frame.origin.y + (CGFloat) random()/(CGFloat) RAND_MAX * scrollView.frame.size.height, 23, 27);
    [imageArray addObject:imageView];
    [self addSubview:imageView];
    CGFloat originY = imageView.frame.origin.y + (100 + (CGFloat) random()/(CGFloat) RAND_MAX *(Screen_Heiht - imageView.frame.origin.y - 100 - 65));
    CGFloat originX = (CGFloat) random()/(CGFloat) RAND_MAX * Screen_Width;

    float duration = (originY/Screen_Heiht)*1.0f;
    imageView.animationImages = array;
    imageView.animationDuration = 0.01f;
    imageView.animationRepeatCount = duration/0.01f;
    [imageView startAnimating];

    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint controlPoint = CGPointMake(imageView.frame.origin.x + (originX - imageView.frame.origin.x)/2, imageView.frame.origin.y + arc4random()%100);
    [path moveToPoint:CGPointMake(imageView.frame.origin.x, imageView.frame.origin.y)];
    CGPoint toPoint = CGPointMake(originX, originY);
    [path addQuadCurveToPoint:toPoint controlPoint:controlPoint];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path.CGPath;
    animation.repeatCount = 1;
    animation.duration = duration;

    CABasicAnimation *scaleAnimation  = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:0.1f];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.5f];
    scaleAnimation.duration = duration/3.0f;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = duration;
    group.animations = [NSArray arrayWithObjects: animation,scaleAnimation, nil];
    group.delegate = self;
    group.removedOnCompletion = YES;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    imageView.frame = CGRectMake(controlPoint.x, originY, imageView.frame.size.width, imageView.frame.size.height);
    [group setValue:[NSString stringWithFormat:@"%d",addImageCount] forKey:@"AnimationType"];
    [imageView.layer addAnimation:group forKey:nil];
}

- (void)closeView
{
    [self removeFromSuperview];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView
{
    currentPage = floorf(scrollView.contentOffset.x / scrollView.frame.size.width);

    [self updatePageIndex];
}

- (void)dealloc
{
    imageArray = nil;
    [timer invalidate];
    timer = nil;
}
@end
