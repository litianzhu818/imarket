//
//  CXYLoginViewController.m
//  IMarket
//
//  Created by iMac on 14-8-27.
//  Copyright (c) 2014年 ___cxy___. All rights reserved.
//

#import "CXYLoginViewController.h"

#define koffset 50

@interface CXYLoginViewController ()<UITextFieldDelegate>

@property (nonatomic,strong)IBOutlet UITextField *nameTextF;
@property (nonatomic,strong)IBOutlet UITextField *numberTextF;

@end

@implementation CXYLoginViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_nameTextF resignFirstResponder];
    [_numberTextF resignFirstResponder];
    if (kScreen_Height < 500) {
        [self viewUpMoveOffset:0];
    }

}


#pragma mark textfield delegate------------------------

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (kScreen_Height < 500) {
        [self viewUpMoveOffset:-koffset];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _nameTextF) {
        return [_numberTextF becomeFirstResponder];
    }
    return YES;
}

- (IBAction)login:(id)sender
{
    [_nameTextF resignFirstResponder];
    [_numberTextF resignFirstResponder];
    
    [[CXYAppDelegate sharedAppDelegate] loginSuccess];
}

- (void)viewUpMoveOffset:(CGFloat)offset
{
    __weak __typeof(&*self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = weakSelf.view.frame;
        frame.origin.y = offset;
        weakSelf.view.frame = frame;
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
