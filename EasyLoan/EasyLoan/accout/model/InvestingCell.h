//
//  InvestingCell.h
//  EasyLoan
//
//  Created by ming yang on 16/8/1.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InvestingModel.h"
@interface InvestingCell : UITableViewCell

@property (nonatomic,strong)UILabel *number;

@property (nonatomic,strong)UILabel *amount;

@property (nonatomic,strong)UILabel *percent;

@property (nonatomic,strong)UILabel *totalPercent;


-(void)loadCellWithModel:(InvestingModel *)model;

@end
