//
//  MessageDetailCtl.m
//  EasyLoan
//
//  Created by ming yang on 16/8/12.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import "MessageDetailCtl.h"

@interface MessageDetailCtl ()

@end

@implementation MessageDetailCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
}

-(void)initUI{
    self.navigationItem.title = @"我的消息";
    self.navigationItem.leftBarButtonItem = self.leftBarButton;
    UILabel *titleStr = [[UILabel alloc]initWithFrame:CGRectMake(8, 5, screenWidth / 2 - 8, 30)];
    titleStr.font = SetFont(17);
    titleStr.textAlignment = NSTextAlignmentLeft;
    titleStr.textColor = [UIColor darkGrayColor];
    titleStr.text = _myTitle;
    [self.view addSubview:titleStr];
    
    UILabel *timeStr = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth / 2 , titleStr.top, screenWidth / 2 - 8, titleStr.height)];
    timeStr.font = SetFont(15);
    timeStr.textAlignment = NSTextAlignmentRight;
    timeStr.textColor = [UIColor darkGrayColor];
    timeStr.text = _time;
    [self.view addSubview:timeStr];
    
    UILabel *segement = [[UILabel alloc]initWithFrame:CGRectMake(0, titleStr.bottom, screenWidth, 1)];
    segement.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:segement];
    
    UITextView *contentStr = [[UITextView alloc]initWithFrame:CGRectMake(titleStr.left, segement.bottom + 15, screenWidth - 16, screenHeight - segement.bottom - 15)];
    contentStr.textColor = [UIColor darkGrayColor];
    contentStr.backgroundColor = [UIColor clearColor];
    contentStr.font = SetFont(17);
    contentStr.text = _content;
    contentStr.userInteractionEnabled = NO;
    
    [self.view addSubview:contentStr];
    
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
