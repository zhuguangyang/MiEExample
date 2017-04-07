//
//  invitationCtl.m
//  EasyLoan
//
//  Created by ming yang on 16/7/1.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import "invitationCtl.h"
#import <UShareUI/UShareUI.h>
#import "UMShareTypeViewController.h"

static NSString* const UMS_THUMB_IMAGE = @"http://www.m-ebaby.com/public/images/fenxiang.png";
static NSString* const UMS_WebLink = @"http://www.m-ebaby.com/front/account/app/register?recommendUserId=";//http://www.m-ebaby.com/
//@"http://DESKTOP-485EA0D:9000/front/account/app/register?recommendUserId=";//http://www.m-ebaby.com/

@interface invitationCtl ()

@end

@implementation invitationCtl

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)invitingFriend:(id)sender {
    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_None;
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        [self shareWebPageToPlatformType:platformType];
    }];
}
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    NSString *userID = [[NSUserDefaults standardUserDefaults] valueForKey:UserIdTrue];
    NSString *url = [NSString stringWithFormat:@"%@%@",UMS_WebLink,userID];
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURL =  UMS_THUMB_IMAGE;
    ;
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"我已经在米E宝理财啦。" descr:@"点击注册米E宝" thumImage:[UIImage imageNamed:@"icon_60"]];//
    //设置网页地址
    shareObject.webpageUrl = url;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        
        [self alertWithError:error];
    }];
}

- (void)alertWithError:(NSError *)error
{
    NSString *result = nil;
    if (!error) {
        result = [NSString stringWithFormat:@"Share succeed"];
    }
    else{
        NSMutableString *str = [NSMutableString string];
        if (error.userInfo) {
            for (NSString *key in error.userInfo) {
                [str appendFormat:@"%@ = %@\n", key, error.userInfo[key]];
            }
        }
        if (error) {
            result = [NSString stringWithFormat:@"Share fail with error code: %d\n%@",(int)error.code, str];
        }
        else{
            result = [NSString stringWithFormat:@"Share fail"];
        }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share"
                                                    message:result
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"sure", @"确定")
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)runShareWithType:(UMSocialPlatformType)type
{
//    UMShareTypeViewController *VC = [[UMShareTypeViewController alloc] initWithType:type];
//    [self.navigationController pushViewController:VC animated:YES];
    //网页分享
    

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
