//
//  TimeModel.h
//  EasyLoan
//
//  Created by 许蒙静 on 2016/11/30.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeModel : NSObject
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *day;
@property (nonatomic, copy) NSString *hours;
@property (nonatomic, copy) NSString *minutes;
@property (nonatomic, copy) NSString *month;
@property (nonatomic, copy) NSString *nanos;
@property (nonatomic, copy) NSString *seconds;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *timezoneOffset;

+ (TimeModel *)timeWithDic:(NSDictionary *)dic;
@end
