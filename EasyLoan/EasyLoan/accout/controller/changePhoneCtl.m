//
//  changePhoneCtl.m
//  EasyLoan
//
//  Created by ming yang on 16/6/29.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import "changePhoneCtl.h"

@interface changePhoneCtl ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTF;

@end

@implementation changePhoneCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"更换绑定手机";
    self.navigationItem.leftBarButtonItem =  self.leftBarButton;
}

- (IBAction)sendClick:(id)sender {
    
}

- (IBAction)nextStep:(id)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
