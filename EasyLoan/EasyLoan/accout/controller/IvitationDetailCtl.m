//
//  IvitationDetailCtl.m
//  EasyLoan
//
//  Created by ming yang on 16/7/1.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import "IvitationDetailCtl.h"
 

@interface IvitationDetailCtl ()
@property (weak, nonatomic) IBOutlet UILabel *userLbl;
@property (weak, nonatomic) IBOutlet UILabel *loanMoneyLbl;
@property (weak, nonatomic) IBOutlet UILabel *managerMoneyLbl;
@property (weak, nonatomic) IBOutlet UILabel *rebateAmountLbl;
@property (weak, nonatomic) IBOutlet UILabel *regiserTimeLbl;

@end

@implementation IvitationDetailCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
