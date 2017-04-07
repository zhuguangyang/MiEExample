//
//  TransactionRecordCtl.m
//  EasyLoan
//
//  Created by ming yang on 16/8/4.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import "TransactionRecordCtl.h"
#import "ComonCtl.h"
@interface TransactionRecordCtl ()<UIScrollViewDelegate>{
    UISegmentedControl *segment;
    UIView *underline;
}

@property (nonatomic,strong)ComonCtl *topUpCtl;

@property (nonatomic,strong)ComonCtl *withDrawCrashCtl;

@property (nonatomic,strong)ComonCtl *serviceAmountCtl;

@property (nonatomic,strong)ComonCtl *payBackCtl;

@property (nonatomic,strong)ComonCtl *incomeBillCtl;

@property (nonatomic,strong)ComonCtl *otherCtl;

@property (nonatomic,strong)UIScrollView *scrollView;

@end

@implementation TransactionRecordCtl

-(ComonCtl *)topUpCtl{
    if (!_topUpCtl) {
        _topUpCtl = [ComonCtl new];
        _topUpCtl.purpose = 1;
    }
    return _topUpCtl;
}

-(ComonCtl *)withDrawCrashCtl{
    if (!_withDrawCrashCtl) {
        _withDrawCrashCtl = [ComonCtl new];
        _withDrawCrashCtl.purpose = 2;
    }
    return _withDrawCrashCtl;
}

-(ComonCtl *)serviceAmountCtl{
    if (!_serviceAmountCtl) {
        _serviceAmountCtl = [ComonCtl new];
        _serviceAmountCtl.purpose = 3;
    }
    return _serviceAmountCtl;
}

-(ComonCtl *)payBackCtl{
    if (!_payBackCtl) {
        _payBackCtl = [ComonCtl new];
        _payBackCtl.purpose = 4;
    }
    return _payBackCtl;
}

-(ComonCtl *)incomeBillCtl{
    if (!_incomeBillCtl) {
        _incomeBillCtl = [ComonCtl new];
        _incomeBillCtl.purpose = 5;
    }
    return _incomeBillCtl;
}

-(ComonCtl *)otherCtl{
    if (!_otherCtl) {
        _otherCtl = [ComonCtl new];
        _otherCtl.purpose = 6;
    }
    return _otherCtl;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}


- (void)createSubView {
    self.navigationItem.title = @"交易记录";
    self.navigationItem.leftBarButtonItem = self.leftBarButton;
    //创建头部segment试图
    NSArray *array = @[@"充值",@"提现",@"服务费",@"账单还款",@"账单收入",@"其他"];
    
    segment = [[UISegmentedControl alloc]initWithItems:array];
    
    segment.frame = CGRectMake(10, 10, screenWidth-20, 40);
    
    segment.selectedSegmentIndex = self.index;
    
    segment.tintColor = [UIColor clearColor];//去掉颜色,现在整个segment都看不见
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:11],
                                             NSForegroundColorAttributeName: mainColor};
    [segment setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:11],
                                               NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    [segment setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    
    [segment addTarget:self
                action:@selector(segmentedControlAction:)
      forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:segment];
    
    underline = [[UIView alloc]initWithFrame:CGRectMake(screenWidth/6 * 0, segment.bottom - 2, screenWidth / 6,  2)];
    underline.backgroundColor = mainColor;
    [self.view addSubview:underline];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, segment.bottom, screenWidth, 1)];
    view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, view.bottom, screenWidth, screenHeight - view.bottom)];
    [self.view addSubview:self.scrollView];
    // 设置scrollView的内容
    self.scrollView.contentSize = CGSizeMake(screenWidth * 6, screenHeight - view.bottom);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.scrollView];
    
    
    self.topUpCtl.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    [self.scrollView addSubview:self.topUpCtl.view];
    
    self.withDrawCrashCtl.view.frame = CGRectMake(screenWidth , 0, screenWidth, CGRectGetHeight(self.scrollView.frame));
    [self.scrollView addSubview:self.withDrawCrashCtl.view];
    
    self.serviceAmountCtl.view.frame = CGRectMake(screenWidth *  2, 0, screenWidth, CGRectGetHeight(self.scrollView.frame));
    [self.scrollView addSubview:self.serviceAmountCtl.view];
    
    self.payBackCtl.view.frame = CGRectMake(screenWidth * 3, 0, screenWidth, CGRectGetHeight(self.scrollView.frame));
    [self.scrollView addSubview:self.payBackCtl.view];
    
    self.incomeBillCtl.view.frame = CGRectMake(screenWidth * 4, 0, screenWidth, CGRectGetHeight(self.scrollView.frame));
    [self.scrollView addSubview:self.incomeBillCtl.view];
    
    self.otherCtl.view.frame = CGRectMake(screenWidth * 5, 0, screenWidth, CGRectGetHeight(self.scrollView.frame));
    [self.scrollView addSubview:self.otherCtl.view];
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
    underline.left = screenWidth/6 * sender.selectedSegmentIndex;
    switch (sender.selectedSegmentIndex) {
        case 0:
        {
            self.scrollView.contentOffset = CGPointMake(0, 0);
        }
            break;
        case 1:
        {
            
            self.scrollView.contentOffset = CGPointMake(screenWidth, 0);
        }
            break;
        case 2:
        {
            self.scrollView.contentOffset = CGPointMake(screenWidth * 2, 0);
        }
            break;
        case 3:
        {
             self.scrollView.contentOffset = CGPointMake(screenWidth * 3, 0);
        }
            break;
        case 4:
        {
             self.scrollView.contentOffset = CGPointMake(screenWidth * 4, 0);
        }
            break;
        case 5:
        {
             self.scrollView.contentOffset = CGPointMake(screenWidth * 5, 0);
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
    underline.left = screenWidth/6 * n;
}

@end
