//
//  CXYMarketListViewController.m
//  ParkDemo
//
//  Created by monstar on 14-3-11.
//  Copyright (c) 2014年 cxy. All rights reserved.
//

#import "CXYMarketListViewController.h"
#import "CXYMarketListCell.h"

@interface CXYMarketListViewController ()
{
    NSMutableArray *marketImages;
    NSArray *latArray;
    CXYSearchViewController *searchVC;
}
@end

@implementation CXYMarketListViewController
{
    UITableView *table;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        latArray = @[
//            @{@"name":@"xx超市",@"image_url":@"1.png",@"lat":@"30.553816",@"lng":@"104.066670"},
//            @{@"name":@"xx超市",@"image_url":@"1.png",@"lat":@"30.543338",@"lng":@"104.067913"},
//            @{@"name":@"xx超市",@"image_url":@"1.png",@"lat":@"30.573338",@"lng":@"104.068913"},
//            @{@"name":@"xx超市",@"image_url":@"1.png",@"lat":@"30.567338",@"lng":@"104.067913"},
//            @{@"name":@"xx超市",@"image_url":@"1.png",@"lat":@"30.563338",@"lng":@"104.064913"},
//            @{@"name":@"xx超市",@"image_url":@"1.png",@"lat":@"30.581338",@"lng":@"104.064913"},
//            @{@"name":@"xx超市",@"image_url":@"1.png",@"lat":@"30.578338",@"lng":@"104.068913"},
//            @{@"name":@"xx超市",@"image_url":@"1.png",@"lat":@"30.568338",@"lng":@"104.065913"},
//            ];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavigationBarTitle:@"超市"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    marketImages = [NSMutableArray array];
    for (int i=0;i<10; i++) {
        [marketImages addObject:[NSString stringWithFormat:@"00%d.jpg",i]];
    }
    for (int i=0;i<6; i++) {
        [marketImages addObject:[NSString stringWithFormat:@"01%d.jpg",i]];
    }
   
    
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreen_Width, kScreen_Height-StaNavHeight*2-TabbarHeight)];
    table.dataSource = self;
    table.delegate = self;
    table.rowHeight = 70;
    table.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:table];
    
    
    [self setNavigationBarRightButtonImage:@"search.png"];
    [self.nowplayingButton addTarget:self action:@selector(onSelectType:) forControlEvents:UIControlEventTouchUpInside];
    //button长按事件
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onSearchMarket:)];
    longPress.minimumPressDuration = 0.5; //定义按的时间
    [self.nowplayingButton addGestureRecognizer:longPress];
    
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    
}

-(void)onSearchMarket:(UILongPressGestureRecognizer*)gestureRecognizer{
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        searchVC = [[CXYSearchViewController alloc]initWithNibName:@"CXYSearchViewController" bundle:nil];
        [[UIApplication sharedApplication].keyWindow addSubview:searchVC.view];
    }
}

- (void)onSelectType:(UIButton*)sender
{
    CXYCategoryViewController *categoryVC = [[CXYCategoryViewController alloc]init];
    categoryVC.categoryType = MARKETTYPE;
    [self.navigationController pushViewController:categoryVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return marketImages.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"myCell";
    CXYMarketListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (!cell) {
        cell = [[CXYMarketListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.marketImage.image =[UIImage imageNamed:[marketImages objectAtIndex:indexPath.row]];
    cell.marketName.text = @"XX超市";
    cell.marketAddress.text = @"高新区天府软件园10号";
    cell.marketType.text = @"";
    cell.marketPrice.text = @"";
    cell.marketFree.text = @"打折活动";
    cell.marketDistance.text = @"0.8km";
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [CXYCustomAnimation willDisplayCellAnimation:cell];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CXYMarketTopViewController *marketTopVC = [[CXYMarketTopViewController alloc]initWithNibName:@"CXYMarketTopViewController" bundle:nil];
    [self.navigationController pushViewController:marketTopVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
