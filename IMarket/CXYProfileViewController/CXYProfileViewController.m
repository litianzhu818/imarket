//
//  CXYProfiileViewController.m
//  IMarket
//
//  Created by iMac on 14-8-28.
//  Copyright (c) 2014年 ___cxy___. All rights reserved.
//

#import "CXYProfileViewController.h"

@interface CXYProfileViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *tablev;
    IBOutlet UIView *headerView;
    IBOutlet UIButton *photoButton;
    
    NSArray *dataList;
}
@end

@implementation CXYProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        dataList = @[@"用户名:xxx",@"电话：1333333333",@"设置",@"意见反馈",@"版本更新",@"关于我们"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tablev.tableHeaderView = headerView;
    // Do any additional setup after loading the view from its nib.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataList.count;
}



- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = [dataList objectAtIndex:indexPath.row];
    return cell;
}

- (IBAction)updatePhoto:(id)sender
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
