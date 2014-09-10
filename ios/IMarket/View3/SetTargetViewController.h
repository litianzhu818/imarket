//
//  SetTargetViewController.h
//  ipoca
//
//  Copyright (c) 2013年 monstar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetTargetViewController : CXYBaseViewController
{
    __weak IBOutlet UITableView *tableView;
    NSMutableArray *tableViewDataArray;
    NSMutableDictionary *resultDictionary;
}
@end

