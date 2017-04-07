//
//  TransactionRecordModel.h
//  EasyLoan
//
//  Created by ming yang on 16/8/4.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import "ZXBaseModel.h"

@interface TransactionRecordModel : ZXBaseModel

@property (nonatomic,copy)NSString *amount;

@property (nonatomic,strong)NSDictionary *time;

@property (nonatomic,copy)NSString *balance;

@property (nonatomic,copy)NSString *freeze;

@property (nonatomic,copy)NSString *type;

@end
