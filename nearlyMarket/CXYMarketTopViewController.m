//
//  ColloectionViewController.m
//  ParkDemo
//
//  Created by monstar on 14-3-11.
//  Copyright (c) 2014年 cxy. All rights reserved.
//

#import "CXYMarketTopViewController.h"
#define KCellIdentifier @"identifier"
#import "ShowImageCell.h"
#import "CircleLayout.h"

@interface CXYMarketTopViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,
UICollectionViewDataSource,UIScrollViewDelegate>
{
    IBOutlet UITableView *table;
    IBOutlet UICollectionView *collectionView;
    IBOutlet UIView *headerView;
    IBOutlet CXYShopInfoImageView *marketInfoView;
    IBOutlet UIButton *allGoodsBtn;
    IBOutlet UILabel *sectionHeaderView;
}
@end

@implementation CXYMarketTopViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor colorWithRed:212/255.0 green:215/255.0 blue:218/255.0 alpha:1];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavigationBarTitle:@"XX超市"];
    [self setNavigationBarLeftButtonImage:@"backBtn.png"];
    
	// Do any additional setup after loading the view.
    collectionView.collectionViewLayout = [[CircleLayout alloc] init];
    [collectionView registerClass:[ShowImageCell class] forCellWithReuseIdentifier:KCellIdentifier];
    collectionView.backgroundColor = [UIColor clearColor];
    //    self.collectionView.pagingEnabled = YES;
    [collectionView setContentOffset:CGPointMake(kScreen_Width, 0.0F)];
    
    NSDictionary *dic = @{@"address":@"一环内",@"open_hours":@"08:00~23:00",@"url":@"www.baidu.com",@"tel":@"8888888"};
    [marketInfoView initView];
    [marketInfoView configShopInfoView:dic];
    table.tableHeaderView = headerView;
}

- (IBAction)onGotoPersonalize:(id)sender
{
    CXYPersonalizeViewController *personalizeVC = [[CXYPersonalizeViewController alloc] init];
    personalizeVC.isRecommended = NO;
    [self.navigationController pushViewController:personalizeVC animated:YES];
}

#pragma mark - UICollectionViewDelegate
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)cView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    // must be dequeueReusableCellWithReuseIdentifier !!!!
    ShowImageCell *cell = (ShowImageCell *)[cView dequeueReusableCellWithReuseIdentifier:KCellIdentifier
                                                                            forIndexPath:indexPath];
    if (!cell) {
        NSLog(@"what ? cell is nil ? It's joke !");
        return nil;
    }
    
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%03d.jpg",indexPath.row]];
    cell.titleLabel.text = @"牛奶。。。";
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CXYDetailViewController *detailVC = [[CXYDetailViewController alloc]initWithNibName:@"CXYDetailViewController" bundle:nil];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = [NSString stringWithFormat:@"本超市活动%d",indexPath.row+1];
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return sectionHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.f;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
    //无限循环....
    if (_scrollView == table) {
        return;
    }
    float targetX = _scrollView.contentOffset.x;
    int numCount = [collectionView numberOfItemsInSection:0];
    float ITEM_WIDTH = _scrollView.frame.size.width;
    
    if (numCount>=3)
    {
        if (targetX < ITEM_WIDTH/2) {
            [_scrollView setContentOffset:CGPointMake(targetX+ITEM_WIDTH *numCount, 0)];
        }
        else if (targetX >ITEM_WIDTH/2+ITEM_WIDTH *numCount)
        {
            [_scrollView setContentOffset:CGPointMake(targetX-ITEM_WIDTH *numCount, 0)];
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
