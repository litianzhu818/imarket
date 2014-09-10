//
//  CXYRecordViewController.m
//  IMarket
//
//  Created by iMac on 14-8-28.
//  Copyright (c) 2014年 ___cxy___. All rights reserved.
//

#import "CXYRecordViewController.h"
#import "CXYPointViewController.h"
#import "SetTargetViewController.h"

#import "CALAgendaViewController.h"
#import "NSDate+Agenda.h"
#import "NSDate+ETI.h"
#import "CALAgenda.h"

@interface CXYRecordViewController ()<UICollectionViewDelegate, CALAgendaCollectionViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSArray *dataList;
}
@property (nonatomic,strong)CALAgendaViewController *agendaVc;
@end

@implementation CXYRecordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        dataList = @[@"购物一览",@"积分一览",@"消费统计",@"参与活动"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavigationBarTitle:@"我的消费"];
   
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
    }
    cell.textLabel.text = [dataList objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        NSDateComponents *components = [NSDateComponents new];
        components.month = 9;
        components.day = 6;
        components.year = 2014;
        NSDate *fromDate = [[NSDate gregorianCalendar] dateFromComponents:components];
        components.month = 12;
        components.day = 1;
        NSDate *toDate = [[NSDate gregorianCalendar] dateFromComponents:components];
        
        
        _agendaVc = [[CALAgendaViewController alloc]init];
        _agendaVc.calendarScrollDirection = UICollectionViewScrollDirectionVertical;
        _agendaVc.agendaDelegate = self;
        [_agendaVc setFromDate:fromDate];
        [_agendaVc setToDate:toDate];
        
        _agendaVc.dayStyle = CALDayCollectionViewCellDayUIStyleIOS7;
        [self.navigationController pushViewController:_agendaVc animated:YES];
    }else if(indexPath.row == 1){
        CXYPointViewController *pointVC = [[CXYPointViewController alloc]initWithNibName:@"CXYPointViewController" bundle:nil];
        [self.navigationController pushViewController:pointVC animated:YES];
    }
   
}


#pragma mark - CALAgendaCollectionViewDelegate

- (void)agendaCollectionView:(CALAgendaCollectionView *)agendaCollectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath selectedDate:(NSDate *)selectedDate
{
    NSLog(@"%s %@", __FUNCTION__, selectedDate);
}

- (BOOL)agendaCollectionView:(CALAgendaCollectionView *)agendaCollectionView canSelectDate:(NSDate *)selectedDate
{
    return YES;
}

- (void)agendaCollectionView:(CALAgendaCollectionView *)agendaCollectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath startDate:(NSDate *)startDate endDate:(NSDate *)endDate
{
    NSLog(@"%s %@ -> %@", __FUNCTION__,startDate, endDate);
    if (nil != startDate && nil != endDate) {
        UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Continuer" style:UIBarButtonItemStyleBordered target:self action:nil];
        [[self.agendaVc navigationItem] setRightBarButtonItem:button animated:YES];
    }
    else {
        [[self.agendaVc navigationItem] setRightBarButtonItem:nil animated:YES];
    }
    
}

- (IBAction)onPointExchange:(id)sender
{
    SetTargetViewController *setVC = [[SetTargetViewController alloc]initWithNibName:@"SetTargetViewController" bundle:nil];
    [self.navigationController pushViewController:setVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
