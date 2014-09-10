//
//  IADetailViewController.m
//  ipoca
//
//  Created by cxy on 13-9-23.
//  Copyright (c) 2013年 monstar. All rights reserved.
//

#import "CXYDetailViewController.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

#define NavbarHeight 70

@interface CXYDetailViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *table;
    IBOutlet UIView *headerView;
    IBOutlet UIScrollView *showScroll;

    
     IACXYpageControl* myPageC;
}
@end

@implementation CXYDetailViewController

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
    table.tableHeaderView = headerView;
    showScroll.layer.borderWidth = 2;
    showScroll.layer.borderColor = [UIColor purpleColor].CGColor;
    for (int i=0; i<4; i++) {
        CXYAsynImageBtn *goodsImageV = [[CXYAsynImageBtn alloc]initWithFrame:CGRectMake(300*i, 0, 300, 300)];
        goodsImageV.imageURL = @"1.png";
        goodsImageV.tag = 100+i;
        [showScroll addSubview:goodsImageV];
    }
    
    myPageC = [[IACXYpageControl alloc]init];
    myPageC.frame = CGRectMake(120,showScroll.frame.origin.y+showScroll.frame.size.height - 30, 80, 20);
    myPageC.numberOfPages = 4;
    [myPageC addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged];
    [showScroll.superview addSubview:myPageC];
    myPageC.currentPage = 0;
    // Do any additional setup after loading the view.
}

-(void) turnPage
{
    int whichPage = myPageC.currentPage;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.2f];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	showScroll.contentOffset = CGPointMake(showScroll.frame.size.width * whichPage, 0.0f);
	[UIView commitAnimations];
    [myPageC setCurrentPage:whichPage];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self setNavigationBarLeftButtonImage:@"backBtn.png"];
    [self setNavigationBarTitle:@"商品详情"];
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    showScroll.contentSize = CGSizeMake(300*4, 300);
    NSLog(@"========%f",self.view.frame.size.height);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = @"评论。。。。。";
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = (int)(scrollView.contentOffset.x/scrollView.frame.size.width);
    myPageC.currentPage = index;
}

- (IBAction)onGotoMarket:(id)sender
{
    NSArray *navsList = [self.navigationController viewControllers];
    for (UIViewController *vc in navsList) {
        if ([vc isKindOfClass:[CXYMarketTopViewController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
            return;
        }
    }
    
    CXYMarketTopViewController *marketTopVC = [[CXYMarketTopViewController alloc]initWithNibName:@"CXYMarketTopViewController" bundle:nil];
    [self.navigationController pushViewController:marketTopVC animated:YES];
}

- (IBAction)onFollowGoods:(id)sender
{
    CXYAsynImageBtn *btn = (CXYAsynImageBtn*)[showScroll viewWithTag:myPageC.currentPage+100];
    [CXYCustomAnimation followAnimation:btn];
}

-(void)scaleImage:(UIButton*)sender
{
   
//    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:imagesArray.count];
//    for (int i = 0; i<imagesArray.count; i++) {
//    
//        NSString *url = [[imagesArray objectAtIndex:i] objectForKey:@"url"];
//        MJPhoto *photo = [[MJPhoto alloc] init];
//        photo.url = [NSURL URLWithString:url];
//        photo.srcImageView = ((UIButton*)[myScrollV viewWithTag: 11011+i]).imageView;
//        [photos addObject:photo];
//    }
//    
//    browser = [[MJPhotoBrowser alloc] init];
//    browser.currentPhotoIndex = page;
//    browser.photos = photos;
//    [browser show];
}



//-(void) leftMove
//{
//    if(myPageC.currentPage == 0)
//    {
//        return;
//    }
//    int whichPage = myPageC.currentPage - 1;
//    page = whichPage;
//	[UIView animateWithDuration:0.3 animations:^{
//        myScrollV.contentOffset = CGPointMake(myScrollV.frame.size.width * whichPage, 0.0f);
//    }];
//    
//    [myPageC setCurrentPage:whichPage];
//    [self tipHide];
//}
//-(void) rightMove
//{
//    if(myPageC.currentPage == imagesArray.count -1)
//    {
//        return;
//    }
//    int whichPage = myPageC.currentPage + 1;
//    page = whichPage;
//	[UIView animateWithDuration:0.3 animations:^{
//       myScrollV.contentOffset = CGPointMake(myScrollV.frame.size.width * whichPage, 0.0f);
//    }];
//    [myPageC setCurrentPage:whichPage];
//    [self tipHide];
//}
//-(void) tipHide
//{
//    if (page ==0) {
//        tipL.hidden = YES;
//    }
//    else
//    {
//        tipL.hidden = NO;
//    }
//    if (page == imagesArray.count - 1) {
//        tipR.hidden = YES;
//    }
//    else
//    {
//        tipR.hidden = NO;
//    }
//
//}
-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{

}

@end
