//
//  ChangeEquitableCell.h
//  EasyLoan
//
//  Created by ming yang on 16/7/27.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangeEquitableModel.h"

@interface ChangeEquitableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *numberLbl;

@property (weak, nonatomic) IBOutlet UILabel *loanAmount;

@property (weak, nonatomic) IBOutlet UILabel *moneyRate;

@property (weak, nonatomic) IBOutlet UILabel *restMoney;

@property (weak, nonatomic) IBOutlet UILabel *lowPay;

@property (weak, nonatomic) IBOutlet UILabel *finalPayment;

@property (weak, nonatomic) IBOutlet UILabel *repaymentTime;

@property (weak, nonatomic) IBOutlet UILabel *cutOffTime;

@property (weak, nonatomic) IBOutlet UILabel *timeTitle;


-(void)loadCellWithModel:(ChangeEquitableModel*)model;

@end
