//
//  CXYCategoryViewController.m
//  IMarket
//
//  Created by iMac on 14-9-10.
//  Copyright (c) 2014年 ___cxy___. All rights reserved.
//

#import "CXYCategoryViewController.h"

@interface CXYCategoryViewController ()
{
    IBOutlet UIScrollView *scroll;
    IBOutletCollection(UIButton) NSArray *btnsList;
    IBOutletCollection(UILabel)  NSArray *titleLabelList;
    NSArray *marketTitleList;
    NSArray *goodsTitleList;
}
@end

@implementation CXYCategoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        marketTitleList = @[@"便利店",@"连锁超市",@"大卖场",@"折扣店",@"会员店",@"大型综合超市",@"仓储式超市",@"...",@"..."];
        goodsTitleList = @[@"饮料",@"食品",@"保健品",@"文具图书",@"厨卫用品",@"纸品",@"水果",@"五金",@"..."];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (_categoryType == MARKETTYPE) {
        [self setNavigationBarTitle:@"选择超市分类"];
        for (int i=0; i<btnsList.count; i++) {
            UILabel *titleLabel =(UILabel*)titleLabelList[i];
            titleLabel.text = marketTitleList[i];
        }
    }else{
        [self setNavigationBarTitle:@"选择商品分类"];
        for (int i=0; i<btnsList.count; i++) {
            UILabel *titleLabel =(UILabel*)titleLabelList[i];
            titleLabel.text = goodsTitleList[i];
        }
    }
    
    [self setNavigationBarLeftButtonImage:@"backBtn.png"];
    scroll.frame = CGRectMake(0, StaNavHeight, kScreen_Width, kScreen_Height-StaNavHeight);
    scroll.contentSize = CGSizeMake(kScreen_Width, kScreen_Height);
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)onSelectGoodType:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
