//
//  accountModel.h
//  EasyLoan
//
//  Created by ming yang on 16/7/6.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXBaseModel.h"
@interface accountModel :ZXBaseModel

@property (nonatomic,copy)NSString *photo;

@property (nonatomic,copy)NSString *name;

@property (nonatomic,copy)NSString *sum_income;

@property (nonatomic,copy)NSString *amount;

@property (nonatomic,copy)NSString *balance;

@property (nonatomic,copy)NSString  *frozen_amount;

@property (nonatomic,copy)NSString *msg;

@property (nonatomic,copy)NSString *error;

@property (nonatomic,assign)NSString *isIps;

@end
