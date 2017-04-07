//
//  RecommendViewController.m
//  EasyLoan
//
//  Created by 许蒙静 on 2016/12/9.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import "RecommendViewController.h"

@interface RecommendViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *qrCodeImgV;

@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的推荐";
    self.navigationItem.leftBarButtonItem = self.leftBarButton;
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
     //[[NSUserDefaults standardUserDefaults] setObject:userIdTrue  forKey:@"userIdTrue"];
    NSString *userIdTrue = [[NSUserDefaults standardUserDefaults] stringForKey:@"userIdTrue"];
    //NSString *str = [NSString stringWithFormat:@"http://www.m-ebaby.com/front/account/app/register?recommendUserId=%@",userIdTrue];
    //www.m-ebaby.com/front/account/app/pubreg
    NSString *str = @"www.m-ebaby.com/front/account/app/pubreg";
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    CIImage *outputImage = [filter outputImage];
    
    //UIImage *image = [UIImage imageWithCIImage:outputImage scale:20.0 orientation:UIImageOrientationUp];
    [self.qrCodeImgV setImage:[self createNonInterpolatedUIImageFormCIImage:outputImage withSize:200]];
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
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
