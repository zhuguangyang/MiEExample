//
//  InvestingCtl.h
//  EasyLoan
//
//  Created by ming yang on 16/8/1.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CallBackBlock )(UIViewController *ctl);

@interface InvestingCtl : UIViewController

@property (nonatomic,assign)CallBackBlock callBackBlock;

@end
