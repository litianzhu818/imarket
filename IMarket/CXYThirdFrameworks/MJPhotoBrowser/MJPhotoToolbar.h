//
//  MJPhotoToolbar.h
//  FingerNews
//
//  Created by mj on 13-9-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJPhotoToolbar : UIView
// all images
@property (nonatomic, strong) NSArray *photos;
// 
@property (nonatomic, assign) NSUInteger currentPhotoIndex;
@end
