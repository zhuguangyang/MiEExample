//
//  invitaterModel.h
//  EasyLoan
//
//  Created by ming yang on 16/7/1.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXBaseModel.h"
@interface invitaterModel : ZXBaseModel

@property (nonatomic,copy) NSString *bid_amount;
@property (nonatomic,copy) NSString *cps_award;
@property (nonatomic,copy) NSString *entityId;
@property (nonatomic,copy) NSString *invitaterId;
@property (nonatomic,copy) NSString *invest_amount;
@property (nonatomic,copy) NSString *is_active;
@property (nonatomic,copy) NSString *month;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *persistent;
@property (nonatomic,copy) NSString *recommend_user_id;
@property (nonatomic,copy) NSString *sign;
@property (nonatomic,copy) NSString *year;
@property (nonatomic, strong) NSMutableDictionary *timeDic;


+ (invitaterModel *)invitaterWithDic:(NSDictionary *)dic;

@end
