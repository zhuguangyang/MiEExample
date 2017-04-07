//
//  MyMessageCtl.m
//  EasyLoan
//
//  Created by ming yang on 16/8/12.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import "MyMessageCtl.h"
#import "UIScrollView+TBSRefresh.h"
#import "MyMessageModel.h"
#import "MyMessageCell.h"
#import "MessageDetailCtl.h"
@interface MyMessageCtl ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tableV;
    NSMutableArray *dataArr;
    NSInteger currpage;
    NSInteger loadingTag;
}


@end

@implementation MyMessageCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTableview];
    
    currpage = 1;
    
    [self dropDownToRefreshData];
    
}


//设置下拉刷新
- (void)dropDownToRefreshData
{
    if (!dataArr) {
        dataArr = [[NSMutableArray alloc]init];
    }
    
    [tableV resetNoMoreData];
    
    [self getInfoFromServerWithPage:1];
    
    
}

//设置上拉加载
- (void)pullUpToLoadData
{
    currpage++;
    [self getInfoFromServerWithPage:currpage];
}

-(void)getInfoFromServerWithPage:(NSInteger)page{
    NSString *userId = [UserManager onlyManager].userId;
    NSDictionary *params = @{@"OPT":@"81",@"id":userId,@"currPage":[NSString stringWithFormat:@"%ld",page]};
    [MyDataService requestParams:params complection:^(id result, NSError *error) {
        // 拿到当前的下拉刷新控件，结束刷新状态
        [tableV.header endRefreshing];
        // 拿到当前的上拉刷新控件，结束刷新状态
        [tableV.footer endRefreshing];
        if (error == nil) {
            if ([result[@"error"] isEqualToString:@"-1"]) {
                NSArray* arr = result[@"list"][@"page"];
                if (loadingTag == 100) {
                    [dataArr removeAllObjects];
                }
                
                if (arr.count == 0) {
                    [tableV endRefreshing];
                    [tableV noticeNoMoreData];
                    return ;
                }
                for (NSDictionary *dic in arr) {
                    
                    MyMessageModel *model = [[MyMessageModel alloc]initWithDataDic:dic];
                    
                    
                    [dataArr addObject:model];
                }
                
                [tableV reloadData];
                
            }else if([result[@"error"]  isEqualToString:@"-3"] || [result[@"error"]  isEqualToString:@"-4"]) {
                [tableV endRefreshing];
                
                [SVProgressHUD showErrorWithStatus:result[@"msg"]];
            }else{
                [tableV endRefreshing];
               
                [SVProgressHUD showErrorWithStatus:@"请检查你的网络"];
            }
        }else{
            [tableV endRefreshing];
           
            [SVProgressHUD showErrorWithStatus:@"请检查你的网络"];
        }
        
    }];
    
}

-(void)setUpTableview{
    self.navigationItem.title = @"我的消息";
    self.navigationItem.leftBarButtonItem = self.leftBarButton;
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-65)];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.showsVerticalScrollIndicator = NO;
    tableV.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [self.view addSubview:tableV];
    
    UIView *clearView = [[UIView alloc]initWithFrame:CGRectMake(0, -1, tableV.frame.size.width, 22)];
    clearView.backgroundColor= [UIColor clearColor];
    [tableV setTableFooterView:clearView];
    
    WEAKSELF
    [tableV refreshWithHeaderBlock:^{
        loadingTag = 100;
        [weakSelf dropDownToRefreshData];
    } withFooterBlock:^{
        loadingTag = 200;
        [weakSelf pullUpToLoadData];
    } withAutoRefresh:YES];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Identifier = @"NotificationCell";
    MyMessageCell *cell = (MyMessageCell *)[tableView dequeueReusableCellWithIdentifier:Identifier];
    MyMessageModel *model = dataArr[indexPath.section];
    if (cell == nil) {
        
        cell = [[MyMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        
        cell.tag = indexPath.section;
        [cell loadCellWithModel:model];
    }
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyMessageModel *model = dataArr[indexPath.section];
    MessageDetailCtl *MVC = [MessageDetailCtl new];
    MVC.myTitle = model.title;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[model.time[@"time"] longLongValue]/1000];
    // 2.格式化日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd hh:mm";
    NSString *time = [formatter stringFromDate:confromTimesp];
   MVC.time =time ;
    MVC.content = model.content;
    
    [self.navigationController pushViewController:MVC animated:YES];
}

@end
