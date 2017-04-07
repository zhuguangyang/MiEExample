//
//  HelpCenterViewController.m
//  EasyLoan
//
//  Created by 许蒙静 on 2016/11/21.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import "HelpCenterViewController.h"
#import "HelpCenterDetailViewController.h"

@interface HelpCenterViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation HelpCenterViewController
//@synthesize dataArr = _dataArr;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"帮助中心";
    self.navigationItem.leftBarButtonItem = self.leftBarButton;
    [self prepareData];
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    
}
- (void)prepareData{
    NSArray *arr = @[@"什么是P2P网贷？",@"我们平台是做什么的？是个什么样的平台",@"怎么保证投资人的资金安全？",@"有什么样的理财产品?",@"理财产品和银行理财有什么区别？",@"投资购买理财产品需要哪些条件？",@"理财产品合理合法的吗？",@"投资后是否可以提前退出？"];
    [self.dataArr addObjectsFromArray:arr];
//    for (int i = 0; i< 10; i++) {
//        [self.dataArr addObject:[NSString stringWithFormat:@"行 %d",i+1]];
//    }
    
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = HexRGB(0xE1E0E3);;
        _tableView.separatorInset = UIEdgeInsetsMake(0, -10, 0, 0);
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tableView;
}

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
//-(void)setDataArr:(NSMutableArray *)dataArr{
//    _dataArr = dataArr;
//    if (_dataArr.count>0) {
//        [self.tableView reloadData];
//    }
//}
#pragma mark --tablevieDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
       //self.dataArr[indexPath.row]
        NSString *str = self.dataArr[indexPath.row];
        cell.textLabel.text = str;
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HelpCenterDetailViewController *detailVC = [[HelpCenterDetailViewController alloc] init];
    detailVC.type = (int)indexPath.row;
    NSString *str = self.dataArr[indexPath.row];
    detailVC.title = str;
    [self.navigationController pushViewController:detailVC animated:YES];
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
