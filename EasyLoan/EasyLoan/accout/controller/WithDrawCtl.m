//
//  WithDrawCtl.m
//  EasyLoan
//
//  Created by ming yang on 16/9/26.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import "WithDrawCtl.h"
#import "MyPickView.h"
#import "BankModel.h"
#import "DebitTableViewCell.h"
#import "PayParamsModel.h"
#import <IPSSDK/RechargeViewController.h>
@interface WithDrawCtl ()<MyPickViewDelegate,UITextFieldDelegate,rechargeDelegate>{
    UITextField *bankTextField;
    UITextField *moneyTextField;
    NSString *selectBankName;
    NSString *bankCode;
    NSMutableArray *_bankInfo;
    PayParamsModel *payParams;
    UIScrollView *mySrollzview;
}

@property (nonatomic,strong) MyPickView *myPickView;


@property (nonatomic,strong) UIView *coverView;

@end

@implementation WithDrawCtl

- (MyPickView *)myPickView
{
    if (!_myPickView) {
        _myPickView = [[MyPickView alloc] initWithDelegate:self];
    }
    
    return _myPickView;
    
}

- (UIView *)coverView
{
    if (!_coverView){
        _coverView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _coverView.backgroundColor = [UIColor colorWithWhite:.7 alpha:.6];
    }
    return _coverView;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestBankData];
}


-(void)requestBankData{
    NSDictionary *params = @{@"OPT":@"189"};
    [MyDataService requestParams:params complection:^(id result, NSError *error) {
        if (error == nil) {
            if ([result[@"error"]  isEqualToString:@"-1"]) {
                NSArray* arr = result[@"list"];
                _bankInfo = [NSMutableArray array];
                if (arr&&![arr isKindOfClass:[NSNull class]]) {
                    for (NSDictionary *dic in arr) {
                        
                        BankModel *model = [BankModel new];
                        
                        [model setValuesForKeysWithDictionary:dic];
                        
                        [_bankInfo addObject:model];
                    }
                }
               
                

            }else if([result[@"error"]  isEqualToString:@"-3"] || [result[@"error"]  isEqualToString:@"-4"]) {
            
                [SVProgressHUD showErrorWithStatus:result[@"msg"]];
            }
        }else{
            NSLog(@"%@",error);
           
            [SVProgressHUD showErrorWithStatus:@"无法获取银行卡列表"];
        }

    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)creatUI{
    self.navigationItem.title = @"充值";
    self.navigationItem.leftBarButtonItem = self.leftBarButton;
    mySrollzview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenWidth - 64)];
    [self.view addSubview:mySrollzview];
    for (int i = 0; i < 2; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, i * 100 + 20, screenWidth / 2 - 10, 30)];
        label.text = i == 1 ? @"充值银行卡" : @"充值金额";
        label.font = SetFont(18);
        label.textColor = [UIColor lightGrayColor];
        [mySrollzview addSubview:label];
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10,i * 100 + 50 , screenWidth - 20, 40)];
        view.backgroundColor  = [UIColor whiteColor];
        view.layer.cornerRadius = 5;
        [mySrollzview addSubview:view];
        
        if (i==0) {
            UILabel *startLbl = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 40, 40)];
            startLbl.text = @"金额";
            [view addSubview:startLbl];
            
            UILabel *endLbl = [[UILabel alloc]initWithFrame:CGRectMake(view.width - 30, 0, 30, 40)];
            endLbl.text = @"元";
            [view addSubview:endLbl];
        }
        
        
        
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(50,0, view.width - 80, 40)];

        textField.layer.masksToBounds = NO;
        textField.tag = 50 + i;
        textField.placeholder = i == 1 ?  @"请选择" : @"金额";
        if (i==1) {
            bankTextField = textField;
            bankTextField.delegate = self;
           bankTextField.enabled = YES;
            bankTextField.text = nil;
            [view addSubview:bankTextField];
        }else{
            moneyTextField = textField;
            moneyTextField.keyboardType = UIKeyboardTypeNumberPad;
            [view addSubview:moneyTextField];
        }
        
        
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(30, 200 + 30, screenWidth - 60, 40)];
    btn.layer.cornerRadius = 5;
    [btn setTitle:@"充值" forState:UIControlStateNormal];
    btn.backgroundColor = SetColor(86, 176, 244);
    [btn addTarget:self action:@selector(requestToPayWithSender:) forControlEvents:UIControlEventTouchUpInside];
    [mySrollzview addSubview:btn];
}

-(void)requestToPayWithSender:(UIButton *)sender{
    sender.enabled = !sender.selected;
     NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:UserId];
    NSDictionary *params = @{@"OPT":@"190",@"bankCode":bankCode,@"amount":moneyTextField.text,@"userId":userId};
    [MyDataService requestParams:params complection:^(id result, NSError *error) {
        if (error == nil) {
            if ([result[@"error"]  isEqualToString:@"-1"]) {
                NSDictionary *dic = result[@"map"];
                payParams = [[PayParamsModel alloc]initWithDataDic:dic];
                [RechargeViewController rechargeWithPlatform:@"米E宝" pMerCode:payParams.pMerCode pMerBillNo:payParams.pMerBillNo pAcctType:payParams.pAcctType pIdentNo:payParams.pIdentNo pRealName:payParams.pRealName pIpsAcctNo:payParams.pIpsAcctNo pTrdDate:payParams.pTrdDate pTrdAmt:payParams.pTrdAmt pChannelType:@"6" pTrdBnkCode:payParams.pTrdBnkCode pMerFee:payParams.pMerFee pIpsFeeType:payParams.pIpsFeeType pS2SUrl:payParams.pS2SUrl pWhichAction:@"2" ViewController:self Delegate:self pMemo1:payParams.pMemo1 pMemo2:payParams.pMemo2 pMemo3:payParams.pMemo3];
            }else if([result[@"error"]  isEqualToString:@"-3"] || [result[@"error"]  isEqualToString:@"-4"]) {
            
                [SVProgressHUD showErrorWithStatus:result[@"msg"]];
            }
        }else{
            NSLog(@"%@",error);
        
            [SVProgressHUD showErrorWithStatus:@"无法支付"];
        }

    }];
}

-(void)rechargeResult:(NSString *)pErrCode ErrMsg:(NSString *)pErrMsg MerCode:(NSString *)pMerCode BillNO:(NSString *)pBillNO IpsAcctNo:(NSString *)pIpsAcctNo AcctType:(NSString *)pAcctType IdentNo:(NSString *)pIdentNo RealName:(NSString *)pRealName TrdDate:(NSString *)pTrdDate TrdAmt:(NSString *)pTrdAmt TrdBnkCode:(NSString *)pTrdBnkCode IpsBillNo:(NSString *)pIpsBillNo CupBillNo:(NSString *)pCupBillNo Memo1:(NSString *)pMemo1 Memo2:(NSString *)pMemo2 Memo3:(NSString *)pMemo3{
    NSString* backErrcode = pErrCode;
    NSString* backErrMsg = pErrMsg;
    NSString* backMerCode = pMerCode;
    NSString* backMerBillNo = pBillNO;
    NSString* memo1 = pMemo1;
    NSString* memo2 = pMemo2;
    NSString* memo3 = pMemo3;
    NSLog(@"充值 收到返回值:%@ %@ %@ %@ 备注:%@ , %@ , %@", backErrcode, backErrMsg, backMerCode, backMerBillNo,memo1,memo2,memo3);
}

#pragma mark - MyPickView delegate
- (void)pickerDidChangeStatus:(int)degree
{
    
    selectBankName = [_bankInfo valueForKey:@"name"][degree];
    bankTextField.text = selectBankName;
    
    bankCode = [[_bankInfo valueForKey:@"code"] objectAtIndex:degree];
    
    [self.coverView removeFromSuperview];
}
- (void)pickerDidCancel
{
    [self.coverView removeFromSuperview];
    [self.myPickView cancelPicker];
}

#pragma mark - UITextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    
   // if (textField.tag != 52 ) {
        
        UIWindow *window = [UIApplication sharedApplication].windows[0];
        
    
    
    
        switch (textField.tag) {
                
            case 51:
                textField =  (UITextField *)[window valueForKey:@"firstResponder"];
                
                [textField resignFirstResponder];
                self.myPickView.pickerArray = [_bankInfo valueForKey:@"name"];
                [self.view addSubview:self.coverView];
                [self.myPickView showInView:self.coverView];
                
                break;
                
                default:
                break;
                
                  return NO;
        }
        
    
    //}
    
    
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    float upY = screenHeight - (textField.tag -20151000+2)*60;
    CGPoint offset = upY  > 310 ? CGPointMake(0, 0) : CGPointMake(0, 310 - upY + 10);
    [UIView animateWithDuration:.3 animations:^{
        mySrollzview.contentOffset = offset;
    }];

    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:.3 animations:^{
       mySrollzview.contentOffset = CGPointMake(0, 0);
    }];

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

@end
