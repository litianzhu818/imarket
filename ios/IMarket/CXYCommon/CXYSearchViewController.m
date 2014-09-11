//
//  CXYSearchViewController.m
//  IMarket
//
//  Created by iMac on 14-9-10.
//  Copyright (c) 2014年 ___cxy___. All rights reserved.
//

#import "CXYSearchViewController.h"

@interface CXYSearchViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITextField *textf;
    IBOutlet UITableView *table;
    NSMutableArray *dataList;
}
@end

@implementation CXYSearchViewController

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
    dataList = [[NSMutableArray alloc]init];
    [textf becomeFirstResponder];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onChangeNoti:) name:@"UITextFieldTextDidChangeNotification" object:textf];
    // Do any additional setup after loading the view from its nib.
}

- (void)onChangeNoti:(NSNotification*)noti
{
    static int i = 0;
    NSString *ss = [NSString stringWithFormat:@"搜索数据--%d",i++];
    [dataList addObject:ss];
    [table reloadData];
}

- (IBAction)onCancel:(id)sender
{
    [textf resignFirstResponder];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [self.view removeFromSuperview];
}

#pragma mark--table view delegate------------------

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
    }
    cell.textLabel.text = dataList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self onCancel:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
