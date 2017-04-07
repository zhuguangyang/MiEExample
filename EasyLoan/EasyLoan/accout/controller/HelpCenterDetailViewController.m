//
//  HelpCenterDetailViewController.m
//  EasyLoan
//
//  Created by 许蒙静 on 2016/11/21.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import "HelpCenterDetailViewController.h"
#import "HeightModel.h"
#import "NSString+Height.h"

@interface HelpCenterDetailViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *titleArr;
@property (nonatomic, strong) NSMutableArray *contentArr;
@property (nonatomic, strong) NSMutableArray *heightArr;


@end

@implementation HelpCenterDetailViewController
{
    CGFloat _font;
    CGFloat _width;
}
//@synthesize dataArr = _dataArr;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.leftBarButton;
    [self prepareData];
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    
}
- (void)prepareData{
    _font = 14;
    _width = screenWidth - 30;
    self.titleArr = [NSMutableArray array];
    self.contentArr = [NSMutableArray array];
    self.heightArr = [NSMutableArray array];
    if (self.type == 0) {
        NSArray *arr1 = @[@"aaaaaaa"];
        NSArray *arr = @[
                         @"P2P是peer-to-peer的缩写，可以理解为“伙伴对伙伴”的意思。p2p网贷是直接消除中间商，借款人和投资人的资料、合同、手续及资金往来支付等，全部通过互联网完成，让企业和个人做贷更方便，更直接。\nP2P网贷最大的优越性，在于它弥补了传统金融机构服务的空缺，满足了普通工薪族家庭及广大中小微企业主的融资、借款需求，相对传统金融来说更便捷。"
                         ];
        [self.titleArr addObjectsFromArray:arr1];
        [self.contentArr addObjectsFromArray:arr];
        
    }
    if (self.type == 1) {
        NSArray *arr1 = @[@"aaaaaaa"];
        NSArray *arr = @[
                         @"我们平台是为了给借款人和投资人提供一个双方交易的信息中介平台，通俗地讲就是，有钱的投资者通过P2P贷款平台将自己的资金投资出去，由P2P贷款平台将钱贷款给需要用钱的人。然后投资者获取高额的利息收入，而P2P贷款平台的那一方获取少量的收益和管理费。\n平台的预期年化收益率在8%-12%左右，这大大高于银行存款利息。同时，为了降低用户的投资门槛，我们是1元起投，希望人人都能参与获得收益。"
                         ];
        [self.titleArr addObjectsFromArray:arr1];
        [self.contentArr addObjectsFromArray:arr];
        
    }
    if (self.type == 2) {
        NSArray *arr1 = @[@"aaaaaaa"];
        NSArray *arr = @[
                         @"首先，我们公司在全国范围内拥有29家分公司及相关机构，还有正在筹建的有54家创客空间和168家线下体验空间，不是说跑就能跑的。第二，我们的投资方向明确，以天津港进口车关税垫付为主要业务，采用不动产抵质押、小额分散的原则。第三，我们正在与银行洽谈资金存管业务，平台的钱随时受到银行监控的，不能随便挪用的。第四，如果借款标的出现违约，我们是可以将全新的进口车低价处理掉，将本息回收。"
                         ];
        [self.titleArr addObjectsFromArray:arr1];
        [self.contentArr addObjectsFromArray:arr];
        
    }
    if (self.type == 3) {
        NSArray *arr1 = @[@"aaaaaaa"];
        NSArray *arr = @[
                         @"我们的投资理财产品都是经过风控严格的审核，确保用户投资安全。目前我们的产品包括，米e宝、米e通、天津港进口车关税垫付等几种。以抵押、质押方式为主的借款，确保资金出借安全。每一个借款标我们都披露出详细的信息，您可以放心购买。"
                         ];
        [self.titleArr addObjectsFromArray:arr1];
        [self.contentArr addObjectsFromArray:arr];
        
    }
    if (self.type == 4) {
        NSArray *arr1 = @[@"aaaaaaa"];
        NSArray *arr = @[
                         @"第一，米e宝的理财产品收益高，在10%左右，银行理财收益在4%左右；第二，米e宝理财1元起步，几乎没有门槛，平时一些零散的钱也可以投。而银行理财通常要5万元起步，对一些刚入社会的年轻人具有较高的门槛。第三，我们的借款标的数量不像银行那么多，所以对我们的用户来说需要先到点得。"
                         ];
        [self.titleArr addObjectsFromArray:arr1];
        [self.contentArr addObjectsFromArray:arr];
        
    }
    if (self.type == 5) {
        NSArray *arr1 = @[@"aaaaaaa"];
        NSArray *arr = @[
                         @"为了保障投资人的合法权益，我们需要对每位投资用户进行实名认证。只要您注册成为我们的用户，并通过实名认证就可以了。操作也非常简单，输入您的手机号进行注册，填写姓名与身份证号码进行认证，然后就可以关联银行卡进行投资了。"
                         ];
        [self.titleArr addObjectsFromArray:arr1];
        [self.contentArr addObjectsFromArray:arr];
        
    }
    if (self.type == 6) {
        NSArray *arr1 = @[@"aaaaaaa"];
        NSArray *arr = @[
                         @"我们平台主打安全合法，坚持在法律法规和行业规范之下开展业务。确保借款人的信息、资金用途合理合法，同时针对每一位投资人，生成投资合同，保障投资人的合法权益。"
                         ];
        [self.titleArr addObjectsFromArray:arr1];
        [self.contentArr addObjectsFromArray:arr];
        
    }
    if (self.type == 7) {
        NSArray *arr1 = @[@"aaaaaaa"];
        NSArray *arr = @[
                         @" 不论出现什么状况，我们会第一时间保障投资人的资金安全。出现您说的这种情况，您的本金不会受到任何影响。您在投资的时候，为了保障您的权益，我们会为您生成一份合同。借款时间、还款时间都会在合同中有约定。如果您在投资的过程中急用钱，请联系我们的客服热线400-997-8788，我们的客服人员会为您解决这个问题。（我们可以为您生成一个借款标，否则中途退出就享受不到收益了。）"
                         ];
        [self.titleArr addObjectsFromArray:arr1];
        [self.contentArr addObjectsFromArray:arr];
        
    }
    for (NSString *str  in self.contentArr) {
        CGFloat height = [str heightWithWidth:screenWidth-30 font:_font];
        [self.heightArr addObject:@(height)];
    }
    
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 34)];
        NSString *str = @"帮助";
        UIFont *font = [UIFont boldSystemFontOfSize:15];
        NSDictionary *attributes = @{NSFontAttributeName:font};
        CGSize size = [str boundingRectWithSize:CGSizeMake(screenWidth, 40) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, screenWidth, ceil(size.height))];
        label.font = font;
        label.text = self.title;
        [headerView addSubview:label];
        _tableView.tableHeaderView = headerView;
    }
    return _tableView;
}


#pragma mark --tablevieDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titleArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell.backgroundColor = [UIColor yellowColor];
        UILabel *label = [UILabel new];
        [cell.contentView addSubview:label];
        int height = [self.heightArr[indexPath.section] intValue];
        label.frame = CGRectMake(15, 0, _width, height);
        label.font = [UIFont systemFontOfSize:_font];
        //label.backgroundColor = [UIColor redColor];
        label.numberOfLines = 0;
        NSString *str = self.contentArr[indexPath.section];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:6];
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:_font],NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@1.0f};
        [attrStr setAttributes:attributes range:NSMakeRange(0, str.length)];
        label.attributedText = attrStr;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.heightArr[indexPath.section] floatValue];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [UIView new];
    headerView.backgroundColor = [UIColor redColor];
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(10, 10, screenWidth, 30);
    label.font = [UIFont systemFontOfSize:17];
    label.text = self.titleArr[section];
    [headerView addSubview:label];
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  0;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView)
    {
        CGFloat sectionHeaderHeight = 50;
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}
@end
