//
//  ShareCtl.h
//  EasyLoan
//
//  Created by ming yang on 16/6/30.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  void(^TypeBlock) (BOOL isSelect);
@interface ShareCtl : BaseViewController

@property (nonatomic,assign)NSInteger index;//当前选中的标签

@property(nonatomic,assign)TypeBlock block;//

@end
