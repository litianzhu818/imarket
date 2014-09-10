//
//  CXYPointViewController.m
//  IMarket
//
//  Created by iMac on 14-8-29.
//  Copyright (c) 2014年 ___cxy___. All rights reserved.
//

#import "CXYPointViewController.h"

@interface CXYPointViewController ()<UITableViewDataSource,UITableViewDelegate>


@end

@implementation CXYPointViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavigationBarTitle:@"消费积分"];
    [self setNavigationBarLeftButtonImage:@"backBtn.png"];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.textLabel.text = @"2014-01-01 15:30";
    cell.detailTextLabel.text = @"xx超市 购物获得  2积分";
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
