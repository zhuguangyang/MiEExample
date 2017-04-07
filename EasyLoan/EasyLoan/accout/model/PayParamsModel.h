//
//  PayParamsModel.h
//  EasyLoan
//
//  Created by ming yang on 16/9/27.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import "ZXBaseModel.h"

@interface PayParamsModel : ZXBaseModel

@property (nonatomic,copy)NSString *pMerBillNo;

@property (nonatomic,copy)NSString *pAcctType;

@property (nonatomic,copy)NSString *pIdentNo;

@property (nonatomic,copy)NSString *pIpsAcctNo;

@property (nonatomic,copy)NSString *pTrdDate;

@property (nonatomic,copy)NSString *pTrdAmt;

@property (nonatomic,copy)NSString *pChannelType;

@property (nonatomic,copy)NSString *pTrdBnkCode;

@property (nonatomic,copy)NSString *pMerFee;

@property (nonatomic,copy)NSString *pIpsFeeType;

@property (nonatomic,copy)NSString *pWebUrl;

@property (nonatomic,copy)NSString *pMemo1;

@property (nonatomic,copy)NSString *pMemo2;

@property (nonatomic,copy)NSString *pMemo3;

@property (nonatomic,copy)NSString *pMerCode;

@property (nonatomic,copy)NSString *amount;

@property (nonatomic,copy)NSString *payNumber;

@property (nonatomic,copy)NSString *pRealName;

@property (nonatomic,copy)NSString *pS2SUrl;

@end
