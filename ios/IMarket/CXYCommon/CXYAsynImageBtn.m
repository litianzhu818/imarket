//
//  CXYAsynImageBtn.m
//  ipoca
//
//  Created by cxy on 13-10-9.
//  Copyright (c) 2013年 monstar. All rights reserved.
//

#import "CXYAsynImageBtn.h"

@implementation CXYAsynImageBtn

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView.backgroundColor = [UIColor whiteColor];

        }
    return self;
}

-(void)setImageURL:(NSString *)imageUrl
{
    if ([imageUrl isEqualToString:@""] || !imageUrl) {
        return;
    }
     [self setImage:[UIImage imageNamed:imageUrl] forState:UIControlStateNormal];
//    SDWebImageManager *manager = [SDWebImageManager sharedManager];
//    [manager downloadWithURL:[NSURL URLWithString:imageUrl]
//                     options:0
//                    progress:^(NSUInteger receivedSize, long long expectedSize) {
//                        // progression tracking code
//                        
//                    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
//                        if (image){
//                            
//                            [weakSelf setImage:image forState:UIControlStateNormal];
//                        }
//                        if (_indicator) {
//                            [_indicator stopAnimating];
//                            [_indicator removeFromSuperview];
//                            _indicator = nil;
//                        }
//     }];

}

- (void)dealloc{  
    _imageURL = nil;
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
