//
//  AuthCtl.m
//  EasyLoan
//
//  Created by ming yang on 16/6/29.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import "AuthCtl.h"

@interface AuthCtl ()
@property (weak, nonatomic) IBOutlet UITextField *realNameTF;
@property (weak, nonatomic) IBOutlet UITextField *identityCardTF;

@end

@implementation AuthCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"实名认证";
    self.navigationItem.leftBarButtonItem =  self.leftBarButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)proveNow:(id)sender {
}


@end
