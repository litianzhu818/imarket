//
//  MJPhotoToolbar.m
//  FingerNews
//
//  Created by mj on 13-9-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MJPhotoToolbar.h"
#import "MJPhoto.h"
#import "CXYpageControl.h"
@interface MJPhotoToolbar()
{
    CXYpageControl  *myPageC;
}
@end

@implementation MJPhotoToolbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    if (_photos.count >= 1) {
        
        myPageC = [[CXYpageControl alloc]init];
        myPageC.frame = CGRectMake(120,self.frame.size.height-30, 80, 20);
        NSLog(@"%f",self.frame.size.height-40);
        myPageC.currentPage = 0;
        myPageC.numberOfPages = _photos.count;
        [self addSubview:myPageC];
        if (_photos.count < 2) {
            myPageC.hidden = YES;
        }
    }
}

- (void)setCurrentPhotoIndex:(NSUInteger)currentPhotoIndex
{
    _currentPhotoIndex = currentPhotoIndex;
    myPageC.currentPage = _currentPhotoIndex;
}

@end
