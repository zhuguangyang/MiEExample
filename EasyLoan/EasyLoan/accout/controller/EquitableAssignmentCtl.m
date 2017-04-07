//
//  EquitableAssignmentCtl.m
//  EasyLoan
//
//  Created by ming yang on 16/7/26.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import "EquitableAssignmentCtl.h"
#import "AssignmentCtl.h"
#import "ChageEquitable.h"
#import "BuyAssignmentCtl.h"
@interface EquitableAssignmentCtl ()<UIScrollViewDelegate>{
    UISegmentedControl *segment;
    UIView *underline;
}

@property (nonatomic,strong)AssignmentCtl *assignmentCtl;

@property (nonatomic,strong)ChageEquitable *changeEquitableCtl;

@property (nonatomic,strong)BuyAssignmentCtl *bugAssignmentCtl;

@property (nonatomic,strong)UIScrollView *scrollView;

@end

@implementation EquitableAssignmentCtl

-(AssignmentCtl *)assignmentCtl{
    if (!_assignmentCtl) {
        _assignmentCtl = [AssignmentCtl new];
    }
    return _assignmentCtl;
}

-(ChageEquitable *)changeEquitableCtl{
    if (!_changeEquitableCtl) {
        _changeEquitableCtl = [ChageEquitable new];
    }
    return _changeEquitableCtl;
}

-(BuyAssignmentCtl *)bugAssignmentCtl{
    if (!_bugAssignmentCtl) {
        _bugAssignmentCtl = [BuyAssignmentCtl new];
    }
    return  _bugAssignmentCtl;
}

- (void)createSubView {
    self.navigationItem.title = @"债权转让";
    
    self.navigationItem.leftBarButtonItem =  self.leftBarButton;
    //创建头部segment试图
    NSArray *array = @[@"可转让",@"转让债权",@"买入债权"];
    
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
    
    underline = [[UIView alloc]initWithFrame:CGRectMake(screenWidth/3 * 0, segment.bottom, screenWidth / 3,  2)];
    underline.backgroundColor = mainColor;
    [self.view addSubview:underline];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, segment.bottom, screenWidth, 1)];
    view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.scrollView];
    // 设置scrollView的内容
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 3, [UIScreen mainScreen].bounds.size.height - 64);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.scrollView];
    
    //    [self addChildViewController:_invitationVC];
    //    [self addChildViewController:_invitaterRecordVC];
    self.assignmentCtl.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    self.changeEquitableCtl.view.frame = CGRectMake(screenWidth, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    self.bugAssignmentCtl.view.frame = CGRectMake(2 * screenWidth, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    
    [self.scrollView addSubview:self.assignmentCtl.view];
    
    [self.scrollView addSubview:self.changeEquitableCtl.view];
    
    [self.scrollView addSubview:self.bugAssignmentCtl.view];
    
    // 设置scrollView的代理
    self.scrollView.delegate = self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    _index =0;
    
    [self createSubView];
    
    
}

- (void)segmentedControlAction:(UISegmentedControl *)sender
{
 //   WEAKSELF
    [self.scrollView setContentOffset:CGPointMake(sender.selectedSegmentIndex * self.scrollView.frame.size.width, 0) animated:NO];
    underline.left = screenWidth/3 * sender.selectedSegmentIndex;
   
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSInteger n = scrollView.contentOffset.x / scrollView.frame.size.width;
    segment.selectedSegmentIndex = n;
    underline.left = screenWidth/3 * n;
}



@end
