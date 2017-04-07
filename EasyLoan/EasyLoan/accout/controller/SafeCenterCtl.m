//
//  SafeCenterCtl.m
//  EasyLoan
//
//  Created by ming yang on 16/6/29.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import "SafeCenterCtl.h"
#import "AuthCtl.h"
#import "ChangeSecretCtl.h"
#import "changePhoneCtl.h"
@interface SafeCenterCtl()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tableV;
    NSArray *tableArr;
    BOOL isExist;
    UIAlertView * alert;
}

@end

@implementation SafeCenterCtl

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self setUpTableView];
    
    if ([_targetString isEqualToString:@"manger"]) {
        
        isExist = YES;
        
    }else{
        
        isExist = [self exist];
        
    }

}

- (BOOL)exist
{
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"exist"] isEqualToString:@""] || [UserManager onlyManager].exist == NO)
    {
        return NO;
    }
    
    return YES;
}


-(void)setUpTableView{
    self.navigationItem.title = @"安全中心";
    self.navigationItem.leftBarButtonItem =  self.leftBarButton;
    tableArr = [NSArray arrayWithObjects:@"实名认证",@"登录密码",nil];
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-65)];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.showsVerticalScrollIndicator = NO;
    tableV.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [self.view addSubview:tableV];
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 500)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 30, screenWidth - 40, 50);
    btn.backgroundColor = SetColor(96, 176, 244);
    btn.titleLabel.textColor = [UIColor whiteColor];
    [btn setTitle:@"退出登录" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(quiteLogin) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = 5;
    [footerView addSubview:btn];
    tableV.tableFooterView = footerView;
}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 100) {
        if (buttonIndex == 0) {
            UISwitch *myswitch = (UISwitch*)[tableV viewWithTag:10];
            
            [myswitch setOn:YES animated:YES];
        }
    }
    
}


-(void)quiteLogin{
    [UserManager onlyManager].isLogin = NO;
    
    // 记录登录状态
    [[NSUserDefaults standardUserDefaults] setObject:@NO forKey:KisLogin];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:UserId];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    
    
    [self.navigationController popViewControllerAnimated:YES];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        UIView *V = [[UIView alloc]initWithFrame:CGRectMake(0, 0, cell.contentView.frame.size.width, 0)];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 150, 20)];
        UILabel *smallLabel = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth - 110, 10, 80, 20)];
        UISwitch *Gswitch = [[UISwitch alloc]initWithFrame:CGRectMake(screenWidth - 70, 10, 20, 20)];
        V.backgroundColor = SetColor(245, 245, 245);
        [cell.contentView addSubview:V];
        if (indexPath.section == 0) {
           
            label.text = tableArr[indexPath.row];
            smallLabel.text = _isLps == YES? @"已认证" : @"未认证";
            [cell.contentView addSubview:smallLabel];
            smallLabel.font = SetFont(18);
            smallLabel.textAlignment = NSTextAlignmentRight;
            smallLabel.textColor = [UIColor lightGrayColor];

            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else{
            label.text = tableArr[indexPath.row + 1];
//            if (indexPath.row == 2) {
//                Gswitch.on = isExist;
//                //Gswitch.on = [UserManager onlyManager].exist;
//                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//                
//                [Gswitch addTarget:self action:@selector(SwitchGesturesCode:) forControlEvents:UIControlEventValueChanged];
//                
//                BOOL exist = [defaults objectForKey:@"exist"];
//                
//                if (exist == YES) {
//                    [Gswitch setOn:YES animated:YES];
//                }else{
//                    [Gswitch setOn:NO animated:YES];
//                }
//
//                [cell.contentView addSubview:Gswitch];
//            }else{
//                smallLabel.text = @"修改";
//                [cell.contentView addSubview:smallLabel];
//                smallLabel.font = SetFont(18);
//                smallLabel.textAlignment = NSTextAlignmentRight;
//                smallLabel.textColor = [UIColor lightGrayColor];
//                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//            }
        }
        label.font = SetFont(18);
        [cell.contentView addSubview:label];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (_isLps == NO) {
            WebViewController *VC  =  [[WebViewController alloc]init];
            VC.type = 0;
            
            NSString *url =  @"http://www.m-ebaby.com/front/account/app/openAccount?userId=";
            NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:UserId];
            VC.urlString = [NSString stringWithFormat:@"%@%@",url,userId];
            VC.tabTitle = @"开户中心";
            NSLog(@"%@",VC.urlString);
            [self.navigationController pushViewController:VC animated:YES];
        }
       

    }else{
        if (indexPath.row == 0) {
            ChangeSecretCtl *changeSecretVC = [[ChangeSecretCtl alloc]init];
            [self.navigationController pushViewController:changeSecretVC animated:YES];
        }
//        else if (indexPath.row == 1){
//            GesturePasswordController *gesturePasswordCtl = [[GesturePasswordController alloc]init];
//            [self.navigationController pushViewController:gesturePasswordCtl animated:YES];
//        }else if (indexPath.row == 3){
//            changePhoneCtl *changePhoneVC = [[changePhoneCtl alloc]init];
//            [self.navigationController pushViewController:changePhoneVC animated:YES];
//        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

//改变cell颜色
- (void) tableView: (UITableView *) tableView  willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor whiteColor];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}


@end
