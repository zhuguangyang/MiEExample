//
//  SafeCenterCtl.h
//  EasyLoan
//
//  Created by ming yang on 16/6/29.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SafeCenterCtlDelegate <NSObject>

- (void)closeGesture:(BOOL)status;

@end

@interface SafeCenterCtl : BaseViewController

@property (nonatomic,assign)id<SafeCenterCtlDelegate>delegate;

@property (nonatomic,strong)NSString *targetString;//manger:管理

@property (nonatomic,assign)BOOL isLps;

@end
