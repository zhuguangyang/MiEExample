//
//  MyInvestmentCtl.m
//  EasyLoan
//
//  Created by ming yang on 16/8/1.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import "MyInvestmentCtl.h"
#import "InvestingCtl.h"
#import "RepayingPulicCtl.h"

@interface MyInvestmentCtl ()<UIScrollViewDelegate>{
    UISegmentedControl *segment;
    UIView *underline;
}

@property (nonatomic,strong)InvestingCtl *investingCtl;

@property (nonatomic,strong)RepayingPulicCtl *repayingCtl;

@property (nonatomic,strong)RepayingPulicCtl *recevingCtl;

@property (nonatomic,strong)UIScrollView *scrollView;

@end

@implementation MyInvestmentCtl

-(InvestingCtl *)investingCtl{
    if (_investingCtl == nil) {
        _investingCtl = [InvestingCtl new];
    }
    return _investingCtl;
}

-(RepayingPulicCtl *)recevingCtl{
    if (!_recevingCtl) {
        _recevingCtl = [RepayingPulicCtl new];
        _recevingCtl.type = 1;
    }
    return  _recevingCtl;
}

-(RepayingPulicCtl *)repayingCtl{
    if (!_repayingCtl) {
        _repayingCtl = [RepayingPulicCtl new];
        _repayingCtl.type = 0;
    }
    return _repayingCtl;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}


- (void)createSubView {
    self.navigationItem.title = @"我的理财";
    self.navigationItem.leftBarButtonItem = self.leftBarButton;
    //创建头部segment试图
    NSArray *array = @[@"投标中",@"还款中",@"已回收"];
    
    segment = [[UISegmentedControl alloc]initWithItems:array];
    
    segment.frame = CGRectMake(10, 10, screenWidth-20, 40);
    
    segment.selectedSegmentIndex = self.index;
    
    segment.tintColor = [UIColor clearColor];//去掉颜色,现在整个segment都看不见
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],
                                             NSForegroundColorAttributeName: mainColor};
    [segment setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],
                                               NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    [segment setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    
    [segment addTarget:self
                action:@selector(segmentedControlAction:)
      forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:segment];
    
    underline = [[UIView alloc]initWithFrame:CGRectMake(screenWidth/3 * 0, segment.bottom - 2, screenWidth / 3,  2)];
    underline.backgroundColor = mainColor;
    [self.view addSubview:underline];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, segment.bottom, screenWidth, 1)];
    view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, view.bottom, screenWidth, screenHeight - view.bottom)];
    [self.view addSubview:self.scrollView];
    // 设置scrollView的内容
    self.scrollView.contentSize = CGSizeMake(screenWidth * 3, screenHeight - view.bottom);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.scrollView];
    
    
    self.investingCtl.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    [self.scrollView addSubview:self.investingCtl.view];
    WEAKSELF
    self.investingCtl.callBackBlock = ^(UIViewController *ctl){
        [weakSelf.navigationController pushViewController:ctl animated:YES];
        
    };
    
    self.repayingCtl.view.frame = CGRectMake(screenWidth , 0, screenWidth, CGRectGetHeight(self.scrollView.frame));
    [self.scrollView addSubview:self.repayingCtl.view];
    self.repayingCtl.callBackBlock = ^(UIViewController *ctl){
        [weakSelf.navigationController pushViewController:ctl animated:YES];
    };
    
    self.recevingCtl.view.frame = CGRectMake(screenWidth *  2, 0, screenWidth, CGRectGetHeight(self.scrollView.frame));
    [self.scrollView addSubview:self.recevingCtl.view];
    self.recevingCtl.callBackBlock = ^(UIViewController *ctl){
        [weakSelf.navigationController pushViewController:ctl animated:YES];
    };

    
        // 设置scrollView的代理
    self.scrollView.delegate = self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    _index = 0;
    
    [self createSubView];
    
    
}

- (void)segmentedControlAction:(UISegmentedControl *)sender
{
    //   WEAKSELF
    [self.scrollView setContentOffset:CGPointMake(sender.selectedSegmentIndex * self.scrollView.frame.size.width, 0) animated:NO];
    underline.left = screenWidth/3 * sender.selectedSegmentIndex;
    
    switch (sender.selectedSegmentIndex) {
        case 0:
        {
            [UIView animateWithDuration:0.3 animations:^{
                self.scrollView.contentOffset = CGPointMake(0, 0);
            }];
        }
            break;
        case 1:
        {
            [UIView animateWithDuration:0.3 animations:^{
                self.scrollView.contentOffset = CGPointMake(screenWidth, 0);
            }];
        }
            break;
        case 2:
        {
            [UIView animateWithDuration:0.3 animations:^{
                self.scrollView.contentOffset = CGPointMake(screenWidth * 2, 0);
            }];
        }
            break;
            
        default:
            break;
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSInteger n = scrollView.contentOffset.x / scrollView.frame.size.width;
    segment.selectedSegmentIndex = n;
    underline.left = screenWidth/3 * n;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger n1 = floor(scrollView.contentOffset.x / scrollView.frame.size.width);
    CGFloat nx = scrollView.contentOffset.x / scrollView.frame.size.width - n1;
    underline.left = screenWidth/3 * (nx+n1);
}
@end
