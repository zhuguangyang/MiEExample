//
//  RecommendViewController1.m
//  EasyLoan
//
//  Created by 许蒙静 on 2016/12/30.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import "RecommendViewController1.h"
#import "WMPageController.h"
#import "PRecommendViewController.h"
#import "CRecommendViewController.h"

@interface RecommendViewController1 ()

@end

@implementation RecommendViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我要借款";
    self.navigationItem.leftBarButtonItem = self.leftBarButton;
    WMPageController *pageController = [self p_defaultController];
    [self addChildViewController:pageController];
    [self.view addSubview:pageController.view];
    
}


- (WMPageController *)p_defaultController {
    NSArray *viewControllers = @[[PRecommendViewController class],[CRecommendViewController class]];
    NSArray *titles = @[@"个人推荐",@"公司推荐"];
    
    WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
    pageVC.menuItemWidth = screenWidth *0.4;
    pageVC.postNotification = YES;
    pageVC.bounces = YES;
    pageVC.hidesBottomBarWhenPushed = YES;
    pageVC.menuViewStyle = WMMenuViewStyleLine;
    pageVC.menuHeight = 34;
    pageVC.menuView.backgroundColor = [UIColor whiteColor];
    pageVC.titleColorNormal = HexRGB(0xbdbdbd);
    pageVC.titleColorSelected = DefaultMainColor;
    pageVC.titleSizeNormal = 14;
    pageVC.titleSizeSelected  = 14;
    return pageVC;
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
