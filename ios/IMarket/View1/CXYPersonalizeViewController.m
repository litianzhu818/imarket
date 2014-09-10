//
//  HomeViewController.m
//  ipoca
//
//  Created by cxy on 13-9-16.
//  Copyright (c) 2013年 monstar. All rights reserved.
//

#import "CXYPersonalizeViewController.h"
#import "CXYDetailViewController.h"
#import "CXYCardView.h"

#define BarBtnSize 31

#define CardCellHeight 215
#define GroupCellHeight 190

#define tagUrl1 @"api/personalize/all_cards_paging"
#define tagUrl2 @"api/personalize/sale_cards_paging"
#define tagUrl3 @"api/personalize/popular_cards_paging"

#define groupUrl @"api/personalize/personalize_nearlybook_paging"
@interface CXYPersonalizeViewController ()
{
    UITableView* cardTableView;
    UITableView* groupTableView;
    float tableOffsety;
    UIButton* lastBtn;
    NSArray* nearlybook_infos1;
    NSDictionary* nearlybook_infos2;
    
    int oCardcount;
    NSMutableDictionary *param1;
   
    NSMutableArray* cardArray;
    
    NSArray* all_scArray;
    NSArray* de_scArray;
    NSArray* popular_scArray;
    NSMutableArray* groupArray;
    
    NSMutableString* address;
    CXYAsynImageBtn* imageBtn;
    EGORefreshTableHeaderView *_refreshHeaderView;
    NSMutableArray* arraySelected;
    
    CGRect orect;
    CGRect rect;

    NSMutableSet* csSet;
    NSMutableSet* setP;
    
    BOOL _reloading;
    BOOL isPull;

    UIAlertView* alt;
    
    BOOL once1;
    BOOL once2;
    BOOL del;

    UIView *bgView;
    
    __block int indexCard; //current page
    int sizeRowCard; //row of every page
    int allCountCard; //all pages
    
    __block int indexGroud;
    int sizeRowGroud;
    int allCountGroud;
    
    BOOL firstIn;
    BOOL isDetailNearly;
    
    UIImageView *starFollowImageView;
    UILabel *followedLabel;
    
    NSArray *conList;
    
    CGFloat tarbarHeight;
}
@end

@implementation CXYPersonalizeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        conList = @[@"新疆特产 西尔丹辣椒丝 芝麻辣椒丁 清真食品 280克*1瓶",@"北味东北黑木耳200g*2袋【京东自营 吃得放心】自营好礼",@"茶人岭昆仑雪菊雅韵礼盒100g【京东自营】中秋专场，满2",@"新货上市坚果零食【囧仁囧食 黑皮花生】健康零食炒货原味",@"蓝翼特级龙井绿茶叶礼盒装 浙江西湖明前春茶2014高山炒",@"洋澄 阳澄湖大闸蟹贵宾卡788型（10只装）中秋团聚季，勿",@"荷兰 进口牛奶 荷高（Globemilk） 全脂纯牛奶 200ml*3",@"澳大利亚 进口牛奶 德运（Devondale）脱脂奶礼盒装1L*6",@"希腊AGRIC阿格利司特级初榨橄榄油1L【京东自营 吃得放",@"红岫留春令碧螺春绿茶茶叶300克京东自营商品，多！快！",@"意大利进口乐贝娜LABELLA特级初榨橄榄油750ml*2瓶礼盒",@"恒大冰泉 长白山天然矿泉水 500ML*24 整箱新老包装，随",@"龙扬茶叶 2014新茶 洞庭湖 【易记】碧螺春绿茶礼盒装 2",@"新加坡进口 owl猫头鹰三合一拉白咖啡（椰糖）600g团圆",@"茶人岭特级清香型安溪铁观音 超值乌龙茶礼盒252g（买一",@"妈说好 有机红豆400克 薏米仁400克 组合装 薏仁米红小"];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(recieveBtnClick:) name:@"buyBtnClick" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(isFollow:) name:@"isFollow" object:nil];
    
    [self addView];
   
    arraySelected = [[NSMutableArray alloc]init];
    csSet = [[NSMutableSet alloc]init];
    setP = [[NSMutableSet alloc]init];
    sizeRowCard = 20;
    sizeRowGroud = 20;
    firstIn = YES;
    
    if (_isRecommended) {
        tarbarHeight = 44;
        [self setNavigationBarTitle:@"iMarket推荐"];
            }
    else{
        tarbarHeight = 0;
        [self setNavigationBarTitle:@"xx超市所卖商品"];
        [self setNavigationBarLeftButtonImage:@"backBtn.png"];
    }
    self.view.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height-tarbarHeight- StaNavHeight);
    self.view.backgroundColor = IABackground;
    [self.nowplayingButton addTarget:self action:@selector(onSearch:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view from its nib.
}

- (void)onSearch:(UIButton*)sender
{
  
}

-(void) addView
{
    [self iaCardtableview];
    [self iaPullRefreshView];
}


-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    isPull = NO;
    rect = self.view.frame;
}



//-(void) iaNetRequest1:(NSString*)urlPath Offset:(NSString*)offset {
//   
//    [param1 setObject:offset forKey:@"offset"];
//    __weak CXYPersonalizeViewController *reself = self;
//    [iaCardNet UrlPath:urlPath Params:param1 onCompletion:^(NSDictionary *dictionary)
//     {
//         if ([offset integerValue] == 0) {
//             indexCard = 0;
//             cardArray = nil;
////             [cardTableView setContentOffset:CGPointMake(0, 0) animated:NO];
//             allCountCard = [[dictionary objectForKey:@"count"]integerValue];
//             cardArray =[[NSMutableArray alloc]initWithArray:[dictionary objectForKey:@"cards"]];
//         }
//         else
//         {
//             NSArray *tempArr = [dictionary objectForKey:@"cards"];
//             for (int i =0; i< tempArr.count; i++) {
//                 [cardArray addObject:[tempArr objectAtIndex:i]];
//             }
//         }
//        
//             
//        if (cardArray.count == 0 && [[NSUserDefaults standardUserDefaults] boolForKey:@"setArea"]) {
//                 UIAlertView* alter = [[UIAlertView alloc]initWithTitle:nil message:@"記事がありません" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                 [alter show];
//        }
//         
//         if ([dictionary objectForKey:@"area_name"]) {
//             
//             if (([_lat floatValue]<0.000001 && [_lat floatValue]>-0.000001) && ([_lng floatValue]<0.000001 && [_lng floatValue]>-0.000001)) {
//                 navbar.smallLabel.text = @"";
//             }
//             else
//             {
//                 navbar.smallLabel.text = [NSString stringWithFormat:@"%@  付近の情報です。",[dictionary objectForKey:@"area_name"]];
//                 navbar.smallLabel.font = [UIFont systemFontOfSize:10];
//                 [navbar.smallLabel sizeToFit];
//                  navbar.smallLabel.center = CGPointMake(self.view.frame.size.width/2+5,53);
//                 UIImageView *tagImage = (UIImageView*)[navbar.smallLabel viewWithTag:-10];
//                 tagImage.hidden = NO;
//             }
//         }
//         
//         [reself becomeEvenNumber];
//         [cardTableView reloadData];
//         
//         if (indicator) {
//             [indicator stopAnimating];
//             [indicator removeFromSuperview];
//             indicator = nil;
//         }
//
//         if (isPull) {
//             [reself performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.5];
//         }
//     } onError:^(NSError *error) {
//         if (isPull) {
//             [reself performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.5];
//          }
//         if (indicator) {
//             [indicator stopAnimating];
//             [indicator removeFromSuperview];
//             indicator = nil;
//         }
//     }];
//}

//-(void) iaNetRequest2:(NSString*)offset
//{
//    NSMutableDictionary* param2 = [NSMutableDictionary dictionary];
//    [param2 setObject:_lat  forKey:@"lat"];
//    [param2 setObject:_lng forKey:@"lng"];
//    [param2 setObject:offset forKey:@"offset"];
//   
//    [iaCardNet UrlPath:groupUrl Params:param2 onCompletion:^(NSDictionary *dictionary)
//     {
//         if ([offset isEqualToString:@"0"]) {
//             indexGroud = 0;
//             [groupTableView setContentOffset:CGPointMake(0, 0) animated:NO];
//             allCountGroud = [[dictionary objectForKey:@"count"]integerValue];
//             groupArray = [[NSMutableArray  alloc]initWithArray:[dictionary objectForKey:@"nearlybook_list"]];
//         }
//         else
//         {
//             NSArray *tempArr = [dictionary objectForKey:@"nearlybook_list"];
//             for (int i=0;i<tempArr.count; i++) {
//                 [groupArray addObject:[tempArr objectAtIndex:i]];
//             }
//         }
//        
//         [groupTableView reloadData];
//     } onError:^(NSError *error) {
//     }];
//}
-(void) becomeEvenNumber
{
    oCardcount = cardArray.count;
    NSMutableDictionary* cardDic = [NSMutableDictionary dictionary];
    if (cardArray.count%2==1) {
        for (NSDictionary* dic in cardArray) {
            for (NSString *strKey in [dic allKeys]) {
                [cardDic setValue:@"" forKey:strKey];
            }
        }
        [cardArray addObject:cardDic];
    }
    
}
-(void) iaCardtableview
{
    cardTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,StaNavHeight, 320, kScreen_Height-StaNavHeight-tarbarHeight-StaNavHeight)];
    cardTableView.clipsToBounds = NO;
    cardTableView.backgroundColor =IABackground;
    cardTableView.dataSource = self;
    cardTableView.delegate = self;
    cardTableView.allowsSelection = NO;
    cardTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:cardTableView];
}
-(void) iaPullRefreshView
{
//    if (_refreshHeaderView == nil) {
//		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - cardTableView.bounds.size.height, self.view.frame.size.width, cardTableView.bounds.size.height)];
//		view.delegate = self;
//		[cardTableView addSubview:view];
//		_refreshHeaderView = view;
//        _refreshHeaderView.hidden = YES;
//    }

}


//-(void)changeNetRequest:(UIButton*)sender offsent:(NSString*)offsent
//{
//    switch (sender.tag) {
//        case 12345671:
//        {
//            [self iaNetRequest1:tagUrl1 Offset:offsent];
//            break;
//        }
//        case 12345672:
//        {
//            [self iaNetRequest1:tagUrl2 Offset:offsent];
//            break;
//        }
//        case 12345673:
//        {
//            [self iaNetRequest1:tagUrl3 Offset:offsent];
//            break;
//        }
//        default:
//            break;
//    }
//
//}

-(void) DoSearch1:(UIButton*)sender
{
    [self DoSearch];
}
-(void) DoSearch //search view
{
    
}
#pragma tableview delegate------------------
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
  if (tableView == cardTableView) {

       static NSString *identifier = @"CardCell";
       UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];

        if (cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.backgroundColor = [UIColor clearColor];
        }
       
        for (UIView *view in cell.contentView.subviews) {
          [view removeFromSuperview];
        }

     
      CXYCardView* cardview = [[CXYCardView alloc]initWithFrame:CGRectMake(0, 0, 320, 160)];
      [cell.contentView addSubview:cardview];
      
      cardview.bgImage1.bgBtn.tag = [[[cardArray objectAtIndex:indexPath.row*2]objectForKey:@"id"] integerValue];
      [cardview.bgImage1.bgBtn addTarget:self action:@selector(bkBtnClick:) forControlEvents:UIControlEventTouchUpInside];
       [cardview.bgImage2.bgBtn addTarget:self action:@selector(bkBtnClick:) forControlEvents:UIControlEventTouchUpInside];
      cardview.bgImage1.bgBtn.imageURL = [NSString stringWithFormat:@"%03d.jpg",indexPath.row*2];
      cardview.bgImage2.bgBtn.imageURL = [NSString stringWithFormat:@"%03d.jpg",indexPath.row*2+1];;
      [cardview.bgImage1.nearlyBtn addTarget:self action:@selector(nearlyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
      [cardview.bgImage2.nearlyBtn addTarget:self action:@selector(nearlyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
      
      cardview.bgImage1.label.text = conList[indexPath.row*2];
      cardview.bgImage2.label.text = conList[indexPath.row*2+1];
      
      cardview.bgImage1.discountLabel.text = [NSString stringWithFormat:@"￥%d",100+indexPath.row*2*10];
      cardview.bgImage2.discountLabel.text = [NSString stringWithFormat:@"￥%d",200+indexPath.row*2+1];
//      [[cardArray objectAtIndex:indexPath.row*2]objectForKey:@"card_url"];
      
//      NSString* isNearlyed1 = [[cardArray objectAtIndex:indexPath.row*2]objectForKey:@"is_clipped"];
      
      
//      if ([isNearlyed1 isEqualToString:@"0"])
//      {
//          cardview.bgImage1.buyBtn.selected = NO;
//      }
//      else
//      {
//          cardview.bgImage1.buyBtn.selected = YES;
//          [arraySelected addObject:[[cardArray objectAtIndex:indexPath.row*2]objectForKey:@"id"]];
//      }
//      
//      cardview.bgImage1.buyBtn.tag = cardview.bgImage1.bgBtn.tag + 1000000;
//      for (NSString* id_Str in arraySelected) {
//          if ([id_Str isEqualToString:[[cardArray objectAtIndex:indexPath.row*2]objectForKey:@"id"]]) {
//              cardview.bgImage1.buyBtn.selected = YES;
//          }
//      }
//      [cardview.bgImage1.nearlyBtn addTarget:self action:@selector(nearlyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//      
//      NSString* sname1;
//      if ([[cardArray objectAtIndex:indexPath.row*2]objectForKey:@"shop_name"]) {
//          sname1 = [[cardArray objectAtIndex:indexPath.row*2]objectForKey:@"shop_name"];
//      }
//      else
//      {
//          sname1 = @"";
//      }
//      [cardview.bgImage1.label setText:RTText(sname1, [[cardArray objectAtIndex:indexPath.row*2]objectForKey:@"name"])];
//      
//      NSString* str1 = [[cardArray objectAtIndex:indexPath.row*2]objectForKey:@"label_priority"];
//      NSString* h1 = [[cardArray objectAtIndex:indexPath.row*2]objectForKey:@"hurry_label"];
//      if ([str1 isEqualToString:@"0"]) {
//          if (![[[cardArray objectAtIndex:indexPath.row*2]objectForKey:@"discount_amount"] isEqualToString:@""]) {
//              cardview.bgImage1.discountLabel.frame = CGRectMake(0, -3, 60, 25);
//              cardview.bgImage1.discountLabel.text =[NSString stringWithFormat:@"¥%@",[[cardArray objectAtIndex:indexPath.row*2]objectForKey:@"discount_amount"]];
//              cardview.bgImage1.discountLabel.font = [UIFont systemFontOfSize:14];
//              cardview.bgImage1.leftImageV.frame = CGRectMake(-4, 5, 60, 35);
//              cardview.bgImage1.leftImageV.image = [UIImage imageNamed:@"IAprice.png"];
//          }else if(![[[cardArray objectAtIndex:indexPath.row*2]objectForKey:@"discount_per"] isEqualToString:@""] && ![[[cardArray objectAtIndex:indexPath.row*2]objectForKey:@"discount_per"] isEqualToString:@"0"])
//          {
//              cardview.bgImage1.leftImageV.frame = CGRectMake(4, -4, 40, 50);
//              cardview.bgImage1.leftImageV.image = [UIImage imageNamed:@"sale.png"];
//              
//              cardview.bgImage1.discountLabel.frame = CGRectMake(-3, 0, 40, 30);
//              cardview.bgImage1.discountLabel.text = [[cardArray objectAtIndex:indexPath.row*2]objectForKey:@"discount_per"];
//              cardview.bgImage1.discountLabel.font = [UIFont systemFontOfSize:25];
//          }
//          else if(![h1 isEqualToString:@""]){
//              cardview.bgImage1.leftImageV.frame = CGRectMake(4, -4, 62, 28);
//              cardview.bgImage1.leftImageV.image =[UIImage imageNamed:[NSString stringWithFormat:@"IAx0%d",[h1 integerValue]]];
//              cardview.bgImage1.discountLabel.text = @"";
//              
//          }
//          else
//          {
//              cardview.bgImage1.discountLabel.text = @"";
//          }
//      }
//      
//      else if([str1 isEqualToString:@"1"])
//      {
//          if(![h1 isEqualToString:@""]){
//              cardview.bgImage1.leftImageV.frame = CGRectMake(4, -4, 60, 30);
//              cardview.bgImage1.leftImageV.image =[UIImage imageNamed:[NSString stringWithFormat:@"IAx0%d",[h1 integerValue]]];
//              cardview.bgImage1.discountLabel.text = @"";
//          }
//          else if (![[[cardArray objectAtIndex:indexPath.row*2]objectForKey:@"discount_amount"] isEqualToString:@""]) {
//              cardview.bgImage1.discountLabel.frame = CGRectMake(0, -3, 60, 25);
//              cardview.bgImage1.discountLabel.text =[NSString stringWithFormat:@"¥%@",[[cardArray objectAtIndex:indexPath.row*2]objectForKey:@"discount_amount"]];
//              cardview.bgImage1.discountLabel.font = [UIFont boldSystemFontOfSize:14];
//              cardview.bgImage1.leftImageV.frame = CGRectMake(-4, 5, 60, 35);
//              cardview.bgImage1.leftImageV.image = [UIImage imageNamed:@"IAprice.png"];
//          }else if(![[[cardArray objectAtIndex:indexPath.row*2]objectForKey:@"discount_per"] isEqualToString:@""] && ![[[cardArray objectAtIndex:indexPath.row*2]objectForKey:@"discount_per"] isEqualToString:@"0"])
//          {
//              cardview.bgImage1.leftImageV.frame = CGRectMake(4, -4, 40, 50);
//              cardview.bgImage1.leftImageV.image = [UIImage imageNamed:@"sale.png"];
//              
//              cardview.bgImage1.discountLabel.frame = CGRectMake(-3, 0, 40, 30);
//              cardview.bgImage1.discountLabel.text = [[cardArray objectAtIndex:indexPath.row*2]objectForKey:@"discount_per"];
//              cardview.bgImage1.discountLabel.font = [UIFont systemFontOfSize:25];
//          }
//          else
//          {
//              cardview.bgImage1.discountLabel.text = @"";
//          }
//          
//      }
//      else
//      {
//          cardview.bgImage1.discountLabel.text = @"";
//      }
//      
//      
//      cardview.bgImage1.rightImageV.hidden = NO;
//      cardview.bgImage1.rightImageV.tag = indexPath.row*2 + 5555555;
//      
//      NSString* pp1 = [[cardArray objectAtIndex:indexPath.row*2]objectForKey:@"is_points"];
//      if ([pp1 isEqualToString:@"0"]) {
//          cardview.bgImage1.rightImageV.hidden = YES;
//          [setP addObject:[[cardArray objectAtIndex:indexPath.row*2]objectForKey:@"id"]];
//      }
//      for (NSArray* csArr in csSet) {
//          NSArray* arr = @[[[cardArray objectAtIndex:indexPath.row*2]objectForKey:@"sc_id"],[[cardArray objectAtIndex:indexPath.row*2]objectForKey:@"shop_id"]];
//          if (arr.count == csArr.count && [arr objectAtIndex:0] == [csArr objectAtIndex:0] && [arr objectAtIndex:1] == [csArr objectAtIndex:1]) {
//              cardview.bgImage1.rightImageV.hidden = YES;
//              [setP addObject:[[cardArray objectAtIndex:indexPath.row*2]objectForKey:@"id"]];
//          }
//      }
//      for (NSString* id_Str in setP) {
//          if ([id_Str isEqualToString:[[cardArray objectAtIndex:indexPath.row*2]objectForKey:@"id"]]) {
//              cardview.bgImage1.rightImageV.hidden = YES;
//          }
//      }
//      ////////
//      cardview.bgImage2.bgBtn.tag = [[[cardArray objectAtIndex:indexPath.row*2+1]objectForKey:@"id"] integerValue];
//      [cardview.bgImage2.bgBtn addTarget:self action:@selector(bkBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//      cardview.bgImage2.bgBtn.imageURL = [[cardArray objectAtIndex:indexPath.row*2+1]objectForKey:@"card_url"];
//      
//      NSString* isNearlyed2 = [[cardArray objectAtIndex:indexPath.row*2+1]objectForKey:@"is_clipped"];
//      if ([isNearlyed2 isEqualToString:@"0"])
//      {
//          cardview.bgImage2.buyBtn.selected = NO;
//      }
//      else
//      {
//          cardview.bgImage2.buyBtn.selected = YES;
//          [arraySelected addObject:[[cardArray objectAtIndex:indexPath.row*2+1]objectForKey:@"id"]];
//          
//      }
//      
//      cardview.bgImage2.buyBtn.tag = cardview.bgImage2.bgBtn.tag + 1000000;
//      for (NSString* id_Str in arraySelected) {
//          if ([id_Str isEqualToString:[[cardArray objectAtIndex:indexPath.row*2+1]objectForKey:@"id"]]) {
//              cardview.bgImage2.buyBtn.selected = YES;
//          }
//      }
//      [cardview.bgImage2.nearlyBtn addTarget:self action:@selector(nearlyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//      
//      NSString* sname2;
//      if ([[cardArray objectAtIndex:indexPath.row*2+1]objectForKey:@"shop_name"]) {
//          sname2 = [[cardArray objectAtIndex:indexPath.row*2+1]objectForKey:@"shop_name"];
//      }
//      else
//      {
//          sname2 = @"";
//      }
//      [cardview.bgImage2.label setText:RTText(sname2, [[cardArray objectAtIndex:indexPath.row*2+1]objectForKey:@"name"])];
//      
//      
//      NSString* str2 = [[cardArray objectAtIndex:indexPath.row*2+1]objectForKey:@"label_priority"];
//      NSString* h2 = [[cardArray objectAtIndex:indexPath.row*2+1]objectForKey:@"hurry_label"];
//      if ([str2 isEqualToString:@"0"]) {
//          if (![[[cardArray objectAtIndex:indexPath.row*2+1]objectForKey:@"discount_amount"] isEqualToString:@""]) {
//              cardview.bgImage2.leftImageV.frame = CGRectMake(-4, 5, 60, 35);
//              cardview.bgImage2.leftImageV.image = [UIImage imageNamed:@"IAprice.png"];
//              
//              cardview.bgImage2.discountLabel.frame = CGRectMake(0, -3, 60, 25);
//              cardview.bgImage2.discountLabel.text =[NSString stringWithFormat:@"¥%@",[[cardArray objectAtIndex:indexPath.row*2+1]objectForKey:@"discount_amount"]];
//              cardview.bgImage2.discountLabel.font = [UIFont systemFontOfSize:14];
//          }else if(![[[cardArray objectAtIndex:indexPath.row*2+1]objectForKey:@"discount_per"] isEqualToString:@""] && ![[[cardArray objectAtIndex:indexPath.row*2 +1]objectForKey:@"discount_per"] isEqualToString:@"0"])
//          {
//              cardview.bgImage2.leftImageV.frame = CGRectMake(4, -4, 40, 50);
//              cardview.bgImage2.leftImageV.image = [UIImage imageNamed:@"sale.png"];
//              
//              cardview.bgImage2.discountLabel.frame = CGRectMake(-3, 0, 40, 30);
//              cardview.bgImage2.discountLabel.text = [[cardArray objectAtIndex:indexPath.row*2+1]objectForKey:@"discount_per"];
//              cardview.bgImage2.discountLabel.font = [UIFont systemFontOfSize:25];
//          }else if(![h2 isEqualToString:@""]){
//              cardview.bgImage2.leftImageV.frame = CGRectMake(4, -4, 60, 30);
//              cardview.bgImage2.leftImageV.image =[UIImage imageNamed:[NSString stringWithFormat:@"IAx0%d",[h2 integerValue]]];
//              cardview.bgImage2.discountLabel.text = @"";
//          }
//          else
//          {
//              cardview.bgImage2.discountLabel.text = @"";
//              
//          }
//          
//      }
//      
//      else if([str2 isEqualToString:@"1"]){
//          if(![h2 isEqualToString:@""]){
//              cardview.bgImage2.leftImageV.frame = CGRectMake(4, -4, 62, 28);
//              cardview.bgImage2.leftImageV.image =[UIImage imageNamed:[NSString stringWithFormat:@"IAx0%d",[h2 integerValue]]];
//              cardview.bgImage2.discountLabel.text = @"";
//          }
//          else if (![[[cardArray objectAtIndex:indexPath.row*2+1]objectForKey:@"discount_amount"] isEqualToString:@""]) {
//              cardview.bgImage2.leftImageV.frame = CGRectMake(-4, 5, 60, 35);
//              cardview.bgImage2.leftImageV.image = [UIImage imageNamed:@"IAprice.png"];
//              
//              cardview.bgImage2.discountLabel.frame = CGRectMake(0, -3, 60, 25);
//              cardview.bgImage2.discountLabel.text =[NSString stringWithFormat:@"¥%@",[[cardArray objectAtIndex:indexPath.row*2+1]objectForKey:@"discount_amount"]];
//              cardview.bgImage2.discountLabel.font = [UIFont boldSystemFontOfSize:14];
//          }else if(![[[cardArray objectAtIndex:indexPath.row*2+1]objectForKey:@"discount_per"] isEqualToString:@""] && ![[[cardArray objectAtIndex:indexPath.row*2 +1]objectForKey:@"discount_per"] isEqualToString:@"0"])
//          {
//              cardview.bgImage2.leftImageV.frame = CGRectMake(4, -4, 40, 50);
//              cardview.bgImage2.leftImageV.image = [UIImage imageNamed:@"sale.png"];
//              
//              cardview.bgImage2.discountLabel.frame = CGRectMake(-3, 0, 40, 30);
//              cardview.bgImage2.discountLabel.text = [[cardArray objectAtIndex:indexPath.row*2+1]objectForKey:@"discount_per"];
//              cardview.bgImage2.discountLabel.font = [UIFont systemFontOfSize:25];
//          }
//          else
//          {
//              cardview.bgImage2.discountLabel.text = @"";
//              
//          }
//      }
//      cardview.bgImage2.rightImageV.hidden = NO;
//      cardview.bgImage2.rightImageV.tag =indexPath.row*2+1 + 5555555;
//      NSString* pp2 = [[cardArray objectAtIndex:indexPath.row*2+1]objectForKey:@"is_points"];
//      if ([pp2 isEqualToString:@"0"]) {
//          cardview.bgImage2.rightImageV.hidden = YES;
//          [setP addObject:[[cardArray objectAtIndex:indexPath.row*2+1]objectForKey:@"id"]];
//      }
//      for (NSArray* csArr in csSet) {
//          NSArray* arr = @[[[cardArray objectAtIndex:indexPath.row*2+1]objectForKey:@"sc_id"],[[cardArray objectAtIndex:indexPath.row*2+1]objectForKey:@"shop_id"]];
//          if (arr.count == csArr.count && [arr objectAtIndex:0] == [csArr objectAtIndex:0] && [arr objectAtIndex:1] == [csArr objectAtIndex:1]) {
//              cardview.bgImage2.rightImageV.hidden = YES;
//              [setP addObject:[[cardArray objectAtIndex:indexPath.row*2+1]objectForKey:@"id"]];
//          }
//      }
//      for (NSString* id_Str in setP) {
//          if ([id_Str isEqualToString:[[cardArray objectAtIndex:indexPath.row*2+1]objectForKey:@"id"]]) {
//              cardview.bgImage2.rightImageV.hidden = YES;
//          }
//      }
//      
//      if (indexPath.row == cardArray.count/2-1 && oCardcount%2==1)
//      {
//          cardview.bgImage2.hidden = YES;
//      }
//      else
//      {
//          cardview.bgImage2.hidden = NO;
//      }

        return cell;
}
else     //groupcard
{
    
}
    return nil;
}


-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == cardTableView) {
//        if (indexPath.row == cardArray.count/2) {
//            return 44;
//        }
        return CardCellHeight;
    }
    if (tableView == groupTableView) {
        if (indexPath.row == groupArray.count) {
            return 44;
        }
        return GroupCellHeight;
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == cardTableView) {
      if (indexPath.row == cardArray.count/2) {
          [self loadMoreEvent:tableView :indexPath];
      }
    }
    if (tableView == groupTableView) {
        if (indexPath.row == groupArray.count) {
            [self loadMoreEvent:tableView :indexPath];
        }
    }
}

-(void)loadMoreEvent:(UITableView *)tableView :(NSIndexPath *)indexPath
{
    if (tableView == cardTableView) {
    int page = (int)(allCountCard/sizeRowCard);
         if ((allCountCard%sizeRowCard)>0)
                 page ++;
         if (indexCard < page-1)
          {
             UITableViewCell *loadMoreCell = [tableView cellForRowAtIndexPath:indexPath];
              UILabel *lastLabel = (UILabel*)[loadMoreCell viewWithTag:-1000];
              lastLabel.text = @"loading...";
             indexCard ++;
              NSString *offset = [NSString stringWithFormat:@"%d",indexCard*20];
              
//             [self changeNetRequest:lastBtn offsent:offset];

             [tableView deselectRowAtIndexPath:indexPath animated:YES];
           }
    }
    if (tableView == groupTableView) {
        int page = (int)(allCountGroud/sizeRowGroud);
        if ((allCountGroud%sizeRowGroud)>0)
            page ++;
        if (indexGroud < page-1)
        {
            UITableViewCell *loadMoreCell = [tableView cellForRowAtIndexPath:indexPath];
            UILabel *lastLabel = (UILabel*)[loadMoreCell viewWithTag:-2000];
            lastLabel.text = @"loading...";
            indexGroud ++;
            NSString *offset = [NSString stringWithFormat:@"%d",indexGroud*20];
            
//            [self iaNetRequest2:offset];
            
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
    }

}


-(void) bkBtnClick:(CXYAsynImageBtn*) bkBtn
{
    CXYDetailViewController* detail = [[CXYDetailViewController alloc]initWithNibName:@"CXYDetailViewController" bundle:nil];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark  //animation
-(void) nearlyBtnClick:(UIButton*)sender
{
    CXYCardBgImage* iAcard = (CXYCardBgImage*)sender.superview;
    [self buyBtnClick:iAcard.buyBtn];
}

-(void)recieveBtnClick:(NSNotification*)noti
{
    UIButton *buyBtn = [noti object];
    if (buyBtn) {
        [self buyBtnClick:buyBtn];
        isDetailNearly = YES;
    }
}

-(void) buyBtnClick:(UIButton*)buyBtn
{
    if (buyBtn.selected) {
        return;
    }
    buyBtn.selected = !buyBtn.selected;
    if (buyBtn.selected)
    {
        
        [arraySelected addObject:[NSString stringWithFormat:@"%d",buyBtn.tag-1000000]];
    }
    
    // hide p
    CXYCardBgImage* img = (CXYCardBgImage*)buyBtn.superview.superview;
    
    NSString*  seleted_scid  =[[cardArray objectAtIndex:(img.rightImageV.tag - 5555555)]objectForKey:@"sc_id"];
    NSString*  seleted_shopid = [[cardArray objectAtIndex:(img.rightImageV.tag - 5555555)]objectForKey:@"shop_id"];

    if (seleted_scid && seleted_shopid) {
        [csSet addObject:@[seleted_scid,seleted_shopid]];
    }
    img.rightImageV.hidden = YES;
  
    NSArray * cellArray = [cardTableView  visibleCells];
    for (UITableViewCell* cell in cellArray)
    {
        CXYCardView* cardv;
        for (UIView* vx in cell.contentView.subviews) {
            if ([vx isKindOfClass:[CXYCardView class]]) {
                cardv = (CXYCardView*)vx;
         
        NSString* sc1 =[[cardArray objectAtIndex:(cardv.bgImage1.rightImageV.tag - 5555555)]objectForKey:@"sc_id"];
        NSString* shop1 =[[cardArray objectAtIndex:(cardv.bgImage1.rightImageV.tag - 5555555)]objectForKey:@"shop_id"];
                NSArray* arr1;
                if (sc1 && shop1) {
                     arr1 = @[sc1,shop1];
                }
        for (NSArray* csArr in csSet) {
            if ([arr1 isEqualToArray:csArr]) {
               
                cardv.bgImage1.rightImageV.hidden = YES;
                [setP addObject:[NSString stringWithFormat:@"%d", cardv.bgImage1.bgBtn.tag]];
            }
          }
                NSString* sc2 =[[cardArray objectAtIndex:(cardv.bgImage2.rightImageV.tag - 5555555)]objectForKey:@"sc_id"];
                NSString* shop2 =[[cardArray objectAtIndex:(cardv.bgImage2.rightImageV.tag - 5555555)]objectForKey:@"shop_id"];
                NSArray* arr2;
                if (sc2 && shop2) {
                    arr2 = @[sc2,shop2];
                }
                for (NSArray* csArr in csSet) {
                    if ([arr2 isEqualToArray:csArr]) {
                        
                        cardv.bgImage2.rightImageV.hidden = YES;
                        [setP addObject:[NSString stringWithFormat:@"%d", cardv.bgImage2.bgBtn.tag]];
                    }
                }


            }
        }
        
    }

    imageBtn = (CXYAsynImageBtn*)[buyBtn superview]; //get btn
    [CXYCustomAnimation followAnimation:imageBtn];
    
}

-(void)btnClick:(UIButton*)sender   //3 buttons
{
    if (sender ==lastBtn)
    {
        return;
    }
    sender.selected = !sender.selected;
    lastBtn.selected = NO;
    
   
    [cardArray removeAllObjects];
//    [self changeNetRequest:sender offsent:@"0"];
    lastBtn = sender;
    lastBtn.adjustsImageWhenHighlighted = NO;
}


#pragma scrollviwe delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *) scrollView // navbar animation1
{
    if (scrollView == cardTableView) {
        [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    }
    if(self.navigaionBarView.frame.origin.y == 0 && scrollView.contentOffset.y == 0){
        [UIView animateWithDuration:0.2 animations:^{
            self.navigaionBarView.frame = CGRectMake(0, -40, 320, StaNavHeight);
            
        }];
        [self performSelector:@selector(doRepeat) withObject:self afterDelay:0.2];
    }
}
-(void) doRepeat //
{
    [UIView animateWithDuration:0.2 animations:^{
        self.navigaionBarView.frame = CGRectMake(0, 0, 320, StaNavHeight);
    }];
    
}


-(void) scrollViewDidScroll:(UIScrollView *)scrollView //navbar animation2
{
    //up pull
    [self.view bringSubviewToFront:self.navigaionBarView];
    if(scrollView.contentOffset.y - tableOffsety >0 && scrollView.contentOffset.y >0 && scrollView.dragging && scrollView.tracking && !scrollView.decelerating)
    {
        [UIView animateWithDuration:0.5 animations:^{
            orect = rect;
            orect.origin.y = orect.origin.y - tarbarHeight;
            orect.size.height = orect.size.height + tarbarHeight;
            self.view.frame = orect;
            
            self.navigaionBarView.frame =CGRectMake(0, -StaNavHeight, kScreen_Width, StaNavHeight);
            
        }];
        scrollView.frame = CGRectMake(0, 0, 320, kScreen_Height-StaNavHeight-TabbarHeight+tarbarHeight);
        
    }
    //down pull
    if (scrollView.contentOffset.y - tableOffsety <0 )
    {
        [UIView animateWithDuration:0.25 animations:^{
            self.view.frame = rect;
            self.navigaionBarView.frame =CGRectMake(0, 0, 320, StaNavHeight);
        }];
        scrollView.frame = CGRectMake(0, StaNavHeight, 320,  kScreen_Height-StaNavHeight-tarbarHeight-StaNavHeight);
       
    }
    tableOffsety = scrollView.contentOffset.y;
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	if (scrollView == cardTableView) {
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    }
}

#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
//    [self changeNetRequest:lastBtn offsent:@"0"];
    _refreshHeaderView.hidden = NO;
    _reloading = YES;
}

- (void)doneLoadingTableViewData{
    
    _refreshHeaderView.hidden = YES;
    _reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:cardTableView];
}


#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    isPull = YES;
  
	[self reloadTableViewDataSource];
   
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}


-(void)isFollow:(NSNotification*)noti
{
    BOOL isSelected = [[noti object] boolValue];
    NSInteger followNum = [followedLabel.text integerValue];
    if (!isSelected) {
       followNum = followNum + 1;
       starFollowImageView.image = [UIImage imageNamed:@"star1.png"];
    }else{
        followNum = (followNum <= 0?0:followNum -1);
        starFollowImageView.image = [UIImage imageNamed:@"star2.png"];
    }
    followedLabel.text = [NSString stringWithFormat:@"%d",followNum];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.view.frame = rect;
   
    
    BOOL isRefresh = [[NSUserDefaults standardUserDefaults]boolForKey:@"isRefresh"];
    if (isRefresh) {
        [arraySelected removeAllObjects];
        [csSet removeAllObjects];
        [setP removeAllObjects];
        [cardArray removeAllObjects];
        cardArray = nil;
        [groupArray removeAllObjects];
        groupArray = nil;
    }
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"isRefresh"];

    if (isPull) {
        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.5];
    }
}
-(void)dealloc
{
    [bgView removeFromSuperview];
    bgView = nil;
    [[NSNotificationCenter defaultCenter]removeObserver:self];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
