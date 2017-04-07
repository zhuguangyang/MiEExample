//
//  invitaterRecordCtl.m
//  EasyLoan
//
//  Created by ming yang on 16/7/1.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import "invitaterRecordCtl.h"
#import "UIScrollView+TBSRefresh.h"
#import "LoginCtl.h"
#import "invitaterModel.h"
#import "InvitaterRecordCell.h"
#import "InvitaterRecordHeaderView.h"

@interface invitaterRecordCtl ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *dataArr;
    UITableView *tableV;
    NSInteger loadingTag;
    NSInteger currpage;
    UIView *backView;
    
}

@end

@implementation invitaterRecordCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableView];
    [self dropDownToRefreshData];
}

#pragma mark network
//设置下拉刷新
- (void)dropDownToRefreshData
{
    if (!dataArr) {
        dataArr = [[NSMutableArray alloc]init];
    }
    
    [tableV resetNoMoreData];
    
    [self getInfoFromServerWithPage:1];
    
    
}

////设置上拉加载
//- (void)pullUpToLoadData
//{
//    currpage++;
//    [self getInfoFromServerWithPage:currpage];
//}

-(void)getInfoFromServerWithPage:(NSInteger)page{
    
    NSDictionary *params = [NSDictionary dictionary];
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:UserId];
    if (!str) {
        LoginCtl *LVC = [LoginCtl new];
        [self.navigationController pushViewController:LVC animated:YES];
    }else{
        NSString *pageStr = [NSString stringWithFormat:@"%ld",page];
        params = @{@"OPT":@"29",@"id":str,@"currPage":pageStr};
        [MyDataService requestParams:params complection:^(id result, NSError *error) {
            // 拿到当前的下拉刷新控件，结束刷新状态
            [tableV.header endRefreshing];
            // 拿到当前的上拉刷新控件，结束刷新状态
            [tableV.footer endRefreshing];
            if (error == nil) {
                
                if ([result[@"error"] isEqualToString:@"-1"]) {
                    NSArray* arr = result[@"page"][@"page"];
                    
                    
                    if (arr.count >0) {
                        tableV.hidden = NO;
                        backView.hidden = YES;
//                        [tableV endRefreshing];
//                        
//                        [tableV noticeNoMoreData];
//                        
//                        [tableV reloadData];
//                        
//                        return ;
                    }else {
                        dispatch_async(dispatch_get_main_queue(), ^{
//                            UIImageView *imageBackground = [[UIImageView alloc]initWithFrame:tableV.frame];
//                            [imageBackground setImage:[UIImage imageNamed:@"暂无数据.jpg"]];
//                            [tableV setBackgroundView:imageBackground];
//                            [tableV setSeparatorStyle:UITableViewCellSeparatorStyleNone];
                            tableV.hidden = YES;
                            backView.hidden = NO;
                            
                        });
                        
                    }
                    
                    for (NSDictionary *dic in arr) {
                        NSLog(@"%@",result);
                       invitaterModel *model = [invitaterModel invitaterWithDic:dic];
                        
                        //  [model setValuesForKeysWithDictionary:dic];
                        
                        [dataArr addObject:model];
                    }
                    
                    [tableV reloadData];
                    
                }else if([result[@"error"]  isEqualToString:@"-3"] || [result[@"error"]  isEqualToString:@"-4"]) {
                    
                    [SVProgressHUD showErrorWithStatus:result[@"msg"]];
                    
                }else if ([result[@"error"] isEqualToString:@"-2"]&[result[@"msg"] isEqualToString:@"解析用户id有误"]){
                   
                    [SVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
                    LoginCtl *LVC = [LoginCtl new];
                    [self.navigationController pushViewController:LVC animated:YES];
                }else {
                    [tableV endRefreshing];
                    
                    [SVProgressHUD showErrorWithStatus:@"请检查你的网络"];
                }
            }else{
                [tableV endRefreshing];
              
                [SVProgressHUD showErrorWithStatus:@"请检查你的网络"];
            }
            
        }];
    }
}

- (void)gotoShare:(UIButton *)btn{
    self.jumpBlock();
}

-(void)creatTableView{
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-64- 60 - 5)];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.showsVerticalScrollIndicator = NO;
    tableV.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [self.view addSubview:tableV];
    
    UIView *clearView = [[UIView alloc]initWithFrame:CGRectMake(0, -1, tableV.frame.size.width, 22)];
    clearView.backgroundColor= [UIColor clearColor];
    [tableV setTableFooterView:clearView];
    
    InvitaterRecordHeaderView *headerView =[[[NSBundle mainBundle] loadNibNamed:@"InvitaterRecordHeaderView" owner:self options:nil] lastObject];
    headerView.frame = CGRectMake(0, 0, screenWidth, 70.5);
//    UILabel *headerV = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 40)];
//    headerV.text = @"我推荐的用户列表";
//    headerV.textColor = [UIColor darkGrayColor];
//    headerV.font = SetFont(18);
//    headerV.textAlignment = NSTextAlignmentCenter;
    tableV.tableHeaderView = headerView;
    
    backView = [UIView new];
    backView.backgroundColor = [UIColor clearColor];
    backView.frame = CGRectMake(0, 0, screenWidth, screenHeight-64- 60 - 5);
    [self.view addSubview:backView];
    CGFloat imgWidth = 200;
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake((screenWidth - imgWidth)*0.5, 50, imgWidth, imgWidth * 1977.0/1835)];
    [backView addSubview:imgV];
    [imgV setImage:[UIImage imageNamed:@"kong"]];
    CGFloat btnWidth = 200;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((screenWidth - btnWidth)*0.5, 320, btnWidth, 40);
    //[btn setTitle:@"暂无数据 点击分享" forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"btnKong"] forState:UIControlStateNormal];
    [backView addSubview:btn];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(gotoShare:) forControlEvents:UIControlEventTouchUpInside];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //static NSString *cellID = @"InvitaterRecordCell";
    InvitaterRecordCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"InvitaterRecordCell" owner:self options:nil].lastObject;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    invitaterModel *model = dataArr[indexPath.row];
    [cell fillDataWithModel:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
