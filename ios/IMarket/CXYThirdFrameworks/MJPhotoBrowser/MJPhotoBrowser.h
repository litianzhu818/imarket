//
//  MJPhotoBrowser.h
//
//  Created by mj on 13-3-4.
//  Copyright (c) 2013年 itcast. All rights reserved.

#import <UIKit/UIKit.h>

@protocol MJPhotoBrowserDelegate;
@interface MJPhotoBrowser : UIViewController <UIScrollViewDelegate>
// delegate
@property (nonatomic, weak) id<MJPhotoBrowserDelegate> delegate;
// all image object
@property (nonatomic, strong) NSArray *photos;
// current show image index
@property (nonatomic, assign) NSUInteger currentPhotoIndex;

// show
- (void)show;
@end

@protocol MJPhotoBrowserDelegate <NSObject>
@optional
// switch some image
- (void)photoBrowser:(MJPhotoBrowser *)photoBrowser didChangedToPageAtIndex:(NSUInteger)index;
@end