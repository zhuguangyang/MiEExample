//
//  invitaterModel.m
//  EasyLoan
//
//  Created by ming yang on 16/7/1.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import "invitaterModel.h"
#import "TimeModel.h"

@implementation invitaterModel

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

+ (invitaterModel *)invitaterWithDic:(NSDictionary *)dic
{
    
    return [[invitaterModel alloc] initWithDictionary:dic];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if([key isEqualToString:@"time"]){
        if (self.timeDic==nil) {
            self.timeDic = [NSMutableDictionary dictionary];
        }
        [self.timeDic setValuesForKeysWithDictionary:(NSDictionary *)value];
    }
    if ([key isEqualToString:@"id"]) {
        self.invitaterId = (NSString *)value;
    }
}

@end
