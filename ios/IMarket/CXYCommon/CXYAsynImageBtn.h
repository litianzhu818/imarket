//
//  CXYAsynImageBtn.h
//  ipoca
//
//  Created by cxy on 13-10-9.
//  Copyright (c) 2013年 monstar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXYAsynImageBtn : UIButton<NSURLConnectionDataDelegate>
@property (nonatomic, strong) NSString *imageURL;
@end
