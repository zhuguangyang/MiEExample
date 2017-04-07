//
//  InvestingModel.h
//  EasyLoan
//
//  Created by ming yang on 16/8/1.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXBaseModel.h"
@interface InvestingModel :ZXBaseModel

@property (nonatomic,copy)NSString *no;

@property (nonatomic,copy)NSString *amount;

@property (nonatomic,copy)NSString *loan_schedule;

@property (nonatomic,copy)NSString *apr;

@end
