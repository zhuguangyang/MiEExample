//
//  RepayingModel.h
//  EasyLoan
//
//  Created by ming yang on 16/8/1.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXBaseModel.h"

@interface RepayingModel : ZXBaseModel

@property (nonatomic,copy)NSString *no;

@property (nonatomic,copy)NSString *bid_amount;

@property (nonatomic,copy)NSString *apr;

@property (nonatomic,copy)NSString *receiving_amount;

@property (nonatomic,copy)NSString *has_received_amount;

@property (nonatomic,assign)long period_unit;

@property (nonatomic,assign)BOOL is_sec_bid;

@property (nonatomic,copy)NSString *has_payback_period;

@property (nonatomic,copy)NSString *period;

@end
