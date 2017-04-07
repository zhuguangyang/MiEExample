//
//  TimeModel.m
//  EasyLoan
//
//  Created by 许蒙静 on 2016/11/30.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import "TimeModel.h"

@implementation TimeModel
+ (TimeModel *)timeWithDic:(NSDictionary *)dic
{
    TimeModel *model = [[TimeModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
