//
//  CXYFollowViewController.m
//  IMarket
//
//  Created by iMac on 14-8-28.
//  Copyright (c) 2014年 ___cxy___. All rights reserved.
//

#import "CXYFollowViewController.h"
#import "CXYFollowTableViewCell.h"
#import "CXYMarketListCell.h"
@interface CXYFollowViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *table;
    NSMutableArray * jpgArr;
}

@end

@implementation CXYFollowViewController

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
    [self setNavigationBarTitle:@"我的关注"];
    [self setNavigationBarRightButtonImage:@"1.png"];
    [self.nowplayingButton addTarget:self action:@selector(onSelectType:) forControlEvents:UIControlEventTouchUpInside];
    jpgArr = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        [jpgArr addObject:[NSString stringWithFormat:@"00%d.jpg",i]];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)onSelectType:(UIButton*)sender
{
    sender.selected = !sender.selected;
    
    [UIView animateWithDuration:0.5 animations:^{
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:table cache:NO];
        [table reloadData];
    } completion:^(BOOL finished) {
           
     }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    static NSString *identifier1 = @"identifier1";
    if (self.nowplayingButton.selected) {
        
        CXYMarketListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[CXYMarketListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.marketImage.image =[UIImage imageNamed:[jpgArr objectAtIndex:indexPath.row]];
        cell.marketName.text = @"XX超市";
        cell.marketAddress.text = @"高新区天府软件园10号";
        cell.marketType.text = @"";
        cell.marketPrice.text = @"";
        cell.marketFree.text = @"打折活动";
        cell.marketDistance.text = @"0.8km";
        return cell;

    }
    CXYFollowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CXYFollowTableViewCell" owner:self options:nil]lastObject];
//        cell.imageView.frame = [CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)];
//        [cell.imageView setImage:[UIImage imageNamed:[jpgArr objectAtIndex:indexPath.row]]];
//        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.nowplayingButton.selected) {
        return 70.f;
    }
    return 100.f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [CXYCustomAnimation willDisplayCellAnimation:cell];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    CXYDetailViewController *detailVC = [[CXYDetailViewController alloc]initWithNibName:@"CXYDetailViewController" bundle:nil];
    [self.navigationController pushViewController:detailVC animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
