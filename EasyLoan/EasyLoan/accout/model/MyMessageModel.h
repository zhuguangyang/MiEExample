//
//  MyMessageModel.h
//  EasyLoan
//
//  Created by ming yang on 16/8/12.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import "ZXBaseModel.h"

@interface MyMessageModel : ZXBaseModel

@property (nonatomic,copy)NSString *title;

@property (nonatomic,strong)NSDictionary *time;

@property (nonatomic,copy)NSString *content;

@end
