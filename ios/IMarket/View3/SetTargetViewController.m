//
//  SetTargetViewController.m
//  ipoca
//
//  Copyright (c) 2013年 monstar. All rights reserved.
//

#import "SetTargetViewController.h"
#import "TargetDetailView.h"


#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Heiht [UIScreen mainScreen].bounds.size.height
#define NavigationBar_Height 44
#define StatusBar_Height 20
#define TabBar_Height 50

#define TableView_CellHeight 150
#define Cell_LeftImageViewFrame CGRectMake(30, 30, 105, 65)
#define Cell_RightImageViewFrame CGRectMake(185, 30, 105, 65)
#define Cell_LeftImageBackgroundViewFrame CGRectMake(10, 10, 145, 140)
#define Cell_RightImageBackgroundViewFrame CGRectMake(165, 10, 145, 140)
#define Cell_LeftImageView_Tag 100
#define Cell_LeftImageView_LabelTag 101
#define Cell_LeftImageView_PointLabelTag 102
#define Cell_RightImageView_Tag 103
#define Cell_RightImageView_LabelTag 104
#define Cell_RightImageView_PointLabelTag 105
#define Cell_LeftImageBackgroundView_Tag 106
#define Cell_RightImageBackgroundView_Tag 107





@interface SetTargetViewController ()

- (void)initViewAndData;
- (void)handleTapGestureEvent:(UITapGestureRecognizer *)recongnizer;
- (void)requestFinish:(NSDictionary*)dictionary;

@end

@implementation SetTargetViewController


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
    [self initViewAndData];
    [self setNavigationBarTitle:@"兑换礼物"];
    [self setNavigationBarLeftButtonImage:@"backBtn.png"];
}

- (void)setGiftDone{

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
- (void)initViewAndData
{
    tableViewDataArray = [[NSMutableArray alloc] init];
    resultDictionary = [[NSMutableDictionary alloc] init];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)_tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *_cell = nil;
    UIImageView *_leftImageView = nil;
    UIView *leftImageBackgroudView = nil;
    UIImageView *_rightImageView = nil;
    UIView *rightImageBackgroudView = nil;
    UILabel *leftlabel = nil;
    UILabel *leftPointLabel = nil;
    UILabel *rightlabel = nil;
    UILabel *rightPointLabel = nil;
    
    static NSString *identifier = @"identifier";
    _cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (_cell == nil)
    {
        _cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        leftImageBackgroudView = [[UIView alloc] initWithFrame:Cell_LeftImageBackgroundViewFrame];
        leftImageBackgroudView.backgroundColor = [UIColor whiteColor];
        leftImageBackgroudView.tag = Cell_LeftImageBackgroundView_Tag;
        
        rightImageBackgroudView = [[UIView alloc] initWithFrame:Cell_RightImageBackgroundViewFrame];
        rightImageBackgroudView.backgroundColor = [UIColor whiteColor];
        rightImageBackgroudView.tag = Cell_RightImageBackgroundView_Tag;

        
        _leftImageView = [[UIImageView alloc] initWithFrame:Cell_LeftImageViewFrame];
        _leftImageView.tag = Cell_LeftImageView_Tag;
        _leftImageView.image = [UIImage imageNamed:@"1.png"];
        _leftImageView.userInteractionEnabled = YES;
        
        _rightImageView = [[UIImageView alloc] initWithFrame:Cell_RightImageViewFrame];
        _rightImageView.image = [UIImage imageNamed:@"1.png"];
        _rightImageView.tag = Cell_RightImageView_Tag;
        _rightImageView.userInteractionEnabled = YES;

        UITapGestureRecognizer *_leftTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureEvent:)];
        [_leftImageView addGestureRecognizer:_leftTapGesture];
        
        UITapGestureRecognizer *_rightTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureEvent:)];
        [_rightImageView addGestureRecognizer:_rightTapGesture];
        
        leftlabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 105, 140, 30)];
        leftlabel.font = [UIFont systemFontOfSize:10.0f];
        leftlabel.textColor = [UIColor blackColor];
        leftlabel.tag = Cell_LeftImageView_LabelTag;
        leftlabel.backgroundColor = [UIColor clearColor];
        leftlabel.numberOfLines = 2;
        
        leftPointLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 120, 140, 15)];
        leftPointLabel.font = [UIFont systemFontOfSize:10.0f];
        leftPointLabel.textColor = [UIColor blackColor];
        leftPointLabel.tag = Cell_LeftImageView_PointLabelTag;
        leftPointLabel.backgroundColor = [UIColor clearColor];
        leftPointLabel.numberOfLines = 0;

        rightlabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 105, 140, 30)];
        rightlabel.font = [UIFont systemFontOfSize:10.0f];
        rightlabel.textColor = [UIColor blackColor];
        rightlabel.tag = Cell_RightImageView_LabelTag;
        rightlabel.backgroundColor = [UIColor clearColor];
        rightlabel.numberOfLines = 2;
        
        rightPointLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 120, 140, 15)];
        rightPointLabel.font = [UIFont systemFontOfSize:10.0f];
        rightPointLabel.textColor = [UIColor blackColor];
        rightPointLabel.tag = Cell_RightImageView_PointLabelTag;
        rightPointLabel.backgroundColor = [UIColor clearColor];
        rightPointLabel.numberOfLines = 0;
        
        [_cell addSubview:leftImageBackgroudView];
        [_cell addSubview:rightImageBackgroudView];
        [_cell addSubview:_leftImageView];
        [_cell addSubview:_rightImageView];
        [_cell addSubview:leftlabel];
        [_cell addSubview:rightlabel];
        [_cell addSubview:leftPointLabel];
        [_cell addSubview:rightPointLabel];

    }
    _leftImageView = (UIImageView*)[_cell viewWithTag:Cell_LeftImageView_Tag];
    _rightImageView = (UIImageView*)[_cell viewWithTag:Cell_RightImageView_Tag];
    leftlabel = (UILabel*)[_cell viewWithTag:Cell_LeftImageView_LabelTag];
    leftPointLabel = (UILabel*)[_cell viewWithTag:Cell_LeftImageView_PointLabelTag];
    rightlabel = (UILabel*)[_cell viewWithTag:Cell_RightImageView_LabelTag];
    rightPointLabel = (UILabel*)[_cell viewWithTag:Cell_RightImageView_PointLabelTag];
    leftImageBackgroudView = (UIView*)[_cell viewWithTag:Cell_RightImageBackgroundView_Tag];


//    [_leftImageView setImageWithURL: [[[[[tableViewDataArray objectAtIndex:indexPath.row - 1] objectAtIndex:0] objectForKey:@"url"] objectAtIndex:0] objectForKey:@"url"]];
//
//    leftlabel.text = [[[tableViewDataArray objectAtIndex:indexPath.row - 1] objectAtIndex:0] objectForKey:@"gift_name"];
//
//
//    leftPointLabel.text = [NSString stringWithFormat:@"%@积分",[[[tableViewDataArray objectAtIndex:indexPath.row - 1] objectAtIndex:0]objectForKey:@"points"]];
//    [leftPointLabel sizeToFit];
//    leftPointLabel.frame = CGRectMake(leftPointLabel.frame.origin.x,leftlabel.frame.origin.y + leftlabel.frame.size.height, leftPointLabel.frame.size.width, leftPointLabel.frame.size.height);
    
//    if ([[tableViewDataArray objectAtIndex:indexPath.row - 1] count] > 1)
//    {
//        [_rightImageView setImageWithURL: [[[[[tableViewDataArray objectAtIndex:indexPath.row - 1] objectAtIndex:1] objectForKey:@"url"] objectAtIndex:0] objectForKey:@"url"]];
//        rightlabel.text = [[[tableViewDataArray objectAtIndex:indexPath.row - 1] objectAtIndex:1] objectForKey:@"gift_name"];
//        
//        rightPointLabel.text = [NSString stringWithFormat:@"%@积分",[[[tableViewDataArray objectAtIndex:indexPath.row - 1] objectAtIndex:1]objectForKey:@"points"]];
//        [rightPointLabel sizeToFit];
//        rightPointLabel.frame = CGRectMake(rightPointLabel.frame.origin.x, rightlabel.frame.origin.y + rightlabel.frame.size.height, rightPointLabel.frame.size.width, rightPointLabel.frame.size.height);
//
//        rightlabel.hidden = NO;
//        rightPointLabel.hidden = NO;
//        _rightImageView.hidden = NO;
//        leftImageBackgroudView.hidden = NO;
//    }
//    else
//    {
//        rightlabel.hidden = YES;
//        _rightImageView.hidden = YES;
//        rightPointLabel.hidden = YES;
//        leftImageBackgroudView.hidden = YES;
//    }
    leftPointLabel.text = @"您将消耗100积分，用于兑换此商品";
    rightPointLabel.text = @"您将消耗100积分，用于兑换此商品";
    _cell.tag = indexPath.row - 1;

    _cell.selectionStyle = UITableViewCellSelectionStyleNone;
    _cell.backgroundColor = [UIColor clearColor];
    return _cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)_tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TableView_CellHeight;
}


- (void)handleTapGestureEvent:(UITapGestureRecognizer *)recongnizer
{
    
    NSIndexPath *indexPath = [tableView indexPathForRowAtPoint:[recongnizer locationInView:tableView]];
    
//    if (!((UIImageView*)recongnizer.view).image)
//    {
//        return;
//    }
    UIImageView *_imageView = [[UIImageView alloc] initWithImage:((UIImageView*)recongnizer.view).image];
    CGPoint convertPoint = [recongnizer.view.superview convertPoint:CGPointMake(recongnizer.view.frame.origin.x, recongnizer.view.frame.origin.y) toView:[UIApplication sharedApplication].keyWindow];    
    _imageView.frame = CGRectMake(convertPoint.x, convertPoint.y, recongnizer.view.frame.size.width, recongnizer.view.frame.size.height) ;
    
    
    TargetDetailView *_detailView = [[TargetDetailView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Heiht)];
//    if (self.view.tag == -1234) {
//        _detailView.tag = -1234;
//    }
//    
//    if (recongnizer.view.tag == Cell_LeftImageView_Tag)
//    {
//        _detailView.dictionary = [[tableViewDataArray objectAtIndex:indexPath.row - 1] objectAtIndex:0];
//    }
//    else
//    {
//        _detailView.dictionary = [[tableViewDataArray objectAtIndex:indexPath.row - 1] objectAtIndex:1];
//    }

    _detailView.image = _imageView.image;
    _detailView.imageViewFrame = _imageView.frame;
    if (self.view.tag == -1234) {
        _detailView.navigationController = nil;
    }else{
        _detailView.navigationController = self.navigationController;
    }
    [_detailView show];
}

- (void)requestData
{
    
}

- (void)requestFinish:(NSDictionary*)dictionary
{
    [resultDictionary setDictionary:dictionary];
    NSArray *array = [dictionary objectForKey:@"gift_info"];
    for (int i = 0; i<[array count]; i = i+2)
    {
        NSMutableArray *mutableArray = [NSMutableArray array];
        [mutableArray addObject:[array objectAtIndex:i]];
        
        if (i+1 <[array count])
        {
            [mutableArray addObject:[array objectAtIndex:i+1]];
        }
        [tableViewDataArray addObject:mutableArray];
    }
    [tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
