//
//  AssignmentCell.h
//  EasyLoan
//
//  Created by ming yang on 16/7/27.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AssignmentModel.h"
@interface AssignmentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *numberLbl;

@property (weak, nonatomic) IBOutlet UILabel *loanAmout;

@property (weak, nonatomic) IBOutlet UILabel *moneyRate;

@property (weak, nonatomic) IBOutlet UILabel *income;

@property (weak, nonatomic) IBOutlet UILabel *detail;

-(void)setCellWithModel:(AssignmentModel *)model;

@end
