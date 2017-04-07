//
//  invitaterRecordCtl.h
//  EasyLoan
//
//  Created by ming yang on 16/7/1.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void(^CallBlock) (UIViewController *ctl);

@interface invitaterRecordCtl : UIViewController

@property(nonatomic,assign)CallBlock block;
@property (nonatomic, copy) void(^jumpBlock)();
@end
