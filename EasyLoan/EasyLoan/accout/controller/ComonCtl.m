//
//  ComonCtl.m
//  EasyLoan
//
//  Created by ming yang on 16/8/4.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import "ComonCtl.h"
#import "UIScrollView+TBSRefresh.h"
#import "TransactionRecordModel.h"
#import "TransationRecordCell.h"
@interface ComonCtl ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tableV;
    NSMutableArray *dataArr;
    NSInteger loadingTag;
    NSInteger currpage;
    
}

@end

@implementation ComonCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTableView];
    
    currpage = 1;
    
    [self dropDownToRefreshData];
    
}

-(void)setTableView{
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64 - 81)];
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

//设置上拉加载
- (void)pullUpToLoadData
{
    currpage++;
    [self getInfoFromServerWithPage:currpage];
}

-(void)getInfoFromServerWithPage:(NSInteger)page{
    NSDictionary *params = [NSDictionary dictionary];
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:UserId];
    
    params = @{@"OPT":@"97",@"purpose":[NSString stringWithFormat:@"%ld",_purpose],@"userId":str,@"currPage":[NSString stringWithFormat:@"%ld",page]};
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
                
                if (arr.count == 0 && loadingTag == 200) {
                    
                    [tableV endRefreshing];
                    
                    [tableV noticeNoMoreData];
                    
                    [tableV reloadData];
                    
                    return ;
                }else if(arr.count == 0){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIImageView *imageBackground = [[UIImageView alloc]initWithFrame:tableV.frame];
                        [imageBackground setImage:[UIImage imageNamed:@"暂无数据.jpg"]];
                        [tableV setBackgroundView:imageBackground];
                        [tableV setSeparatorStyle:UITableViewCellSeparatorStyleNone];
                    });
                    
                }
                
                for (NSDictionary *dic in arr) {
                    
                    TransactionRecordModel *model = [[TransactionRecordModel alloc]initWithDataDic:dic];
                    [dataArr addObject:model];
                }
                
                [tableV reloadData];
                
            }else if([result[@"error"]  isEqualToString:@"-3"] || [result[@"error"]  isEqualToString:@"-4"]) {
                [tableV endRefreshing];
               
                [SVProgressHUD showErrorWithStatus:result[@"msg"]];
                
            }else{
                [tableV endRefreshing];
                
              
            }
        }else{
            [tableV endRefreshing];
         
              [SVProgressHUD showErrorWithStatus:@"请检查你的网络"];
        }
        
    }];
    
}



#pragma tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataArr.count?dataArr.count:0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    static NSString *Identifier = @"TransationRecordCell";
   TransationRecordCell *cell = (TransationRecordCell *)[tableView dequeueReusableCellWithIdentifier:Identifier];
    
    
    TransactionRecordModel *model = dataArr[indexPath.section];
    if (cell == nil) {
        
        cell = [[TransationRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        
    }
    [cell loadCellWithModel:model];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

@end
