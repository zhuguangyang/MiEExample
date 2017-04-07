//
//  ShareCtl.m
//  EasyLoan
//
//  Created by ming yang on 16/6/30.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import "ShareCtl.h"
#import "invitationCtl.h"//邀请的
#import "invitaterRecordCtl.h"//记录

@interface ShareCtl ()<UIScrollViewDelegate>{
    UISegmentedControl *segment;
}

@property (nonatomic,strong)invitationCtl *invitationVC;

@property (nonatomic,strong)invitaterRecordCtl *invitaterRecordVC;

@property (nonatomic,strong)UIScrollView *scrollView;

@end

@implementation ShareCtl

-(invitationCtl *)invitationVC{
    if (!_invitationVC ) {
        _invitationVC = [[invitationCtl alloc]initWithNibName:@"invitationCtl" bundle:nil];
    }
    return _invitationVC;
}

-(invitaterRecordCtl *)invitaterRecordVC{
    if (!_invitaterRecordVC) {
        _invitaterRecordVC = [[invitaterRecordCtl alloc]init];
    }
    return _invitaterRecordVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _index =0;
    [self createSubView];
    
}

- (void)createSubView {
    self.navigationItem.title = @"邀请好友";
    self.navigationItem.leftBarButtonItem =  self.leftBarButton;
    //创建头部segment试图
    NSArray *array = @[@"邀请",@"记录"];
    segment = [[UISegmentedControl alloc]initWithItems:array];
    segment.frame = CGRectMake(10, 10, screenWidth-20, 40);
    segment.selectedSegmentIndex = self.index;
    segment.tintColor = SetColor(92, 171, 234);
    [segment addTarget:self
                action:@selector(segmentedControlAction:)
      forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:segment];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, screenWidth, screenHeight - 64)];
    [self.view addSubview:self.scrollView];
    // 设置scrollView的内容
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 2, [UIScreen mainScreen].bounds.size.height - 64);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:_invitationVC.view];
    
//    [self addChildViewController:_invitationVC];
//    [self addChildViewController:_invitaterRecordVC];
    self.invitationVC.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    self.invitationVC.fatherVC = self;
    self.invitaterRecordVC.view.frame = CGRectMake(screenWidth, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    [self.invitaterRecordVC setJumpBlock:^{
        segment.selectedSegmentIndex = 0;
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }];
    
    [self.scrollView addSubview:_invitationVC.view];
    [self.scrollView addSubview:_invitaterRecordVC.view];
    
    // 设置scrollView的代理
    self.scrollView.delegate = self;
}

- (void)segmentedControlAction:(UISegmentedControl *)sender
{
    [self.scrollView setContentOffset:CGPointMake(sender.selectedSegmentIndex * self.scrollView.frame.size.width, 0) animated:NO];
    
    
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
            
        default:
            break;
    }

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSInteger n = scrollView.contentOffset.x / scrollView.frame.size.width;
    segment.selectedSegmentIndex = n;
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
