//
//  ChangeSecretCtl.m
//  EasyLoan
//
//  Created by ming yang on 16/6/29.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import "ChangeSecretCtl.h"

@interface ChangeSecretCtl ()

@property (weak, nonatomic) IBOutlet UITextField *preSecretTF;

@property (weak, nonatomic) IBOutlet UITextField *mySecretTF;

@property (weak, nonatomic) IBOutlet UITextField *sureSecret;

@end

@implementation ChangeSecretCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改登录密码";
    self.navigationItem.leftBarButtonItem =  self.leftBarButton;
}
- (IBAction)buttonClick:(id)sender {
    NSString *myphone = [[NSUserDefaults standardUserDefaults] objectForKey:phone];
    NSString *mysecrect = [[NSUserDefaults standardUserDefaults] objectForKey:secrect];
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:UserId];
    if ([mysecrect isEqualToString:_preSecretTF.text]) {
        NSDictionary *params  = @{@"OPT":@"191",@"oldpwd":mysecrect,@"newpwd":self.mySecretTF.text,@"userId":userId};
        [MyDataService requestParams:params complection:^(id result, NSError *error) {
            if (error == nil) {
                NSString *err = result[@"error"] ;
                if ([err  isEqualToString:@"-1"] && [_mySecretTF.text isEqualToString:_sureSecret.text]) {
                    [SVProgressHUD showSuccessWithStatus:@"修改密码成功"];
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }else if([err  isEqualToString:@"-3"] || [err  isEqualToString:@"-4"]) {
             
                    [SVProgressHUD showErrorWithStatus:err];
                }else{
                    
                    [SVProgressHUD showErrorWithStatus:@"请检查你的网络"];
                }
                
            }else{
              
                [SVProgressHUD showErrorWithStatus:@"请检查你的网络"];
            }

        }];
    }
else if (_preSecretTF.text == nil || _sureSecret.text == nil || _mySecretTF.text == nil){
    
    [SVProgressHUD showErrorWithStatus:@"全为必填项不能为空"];
    }else if (![_mySecretTF.text isEqualToString:_sureSecret.text]){
        
        [SVProgressHUD showErrorWithStatus:@"新密码与确认密码不一致"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UITextField Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([_preSecretTF isFirstResponder]) {
        [_mySecretTF becomeFirstResponder];
    }else if ([_mySecretTF isFirstResponder]){
        [_sureSecret becomeFirstResponder];
    }else if([_sureSecret isFirstResponder]){
         [textField resignFirstResponder];
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    NSLog(@"tag= %lu",textField.tag);
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    return YES;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
