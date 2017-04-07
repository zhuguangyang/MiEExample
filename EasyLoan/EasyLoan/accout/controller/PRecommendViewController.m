//
//  PRecommendViewController.m
//  EasyLoan
//
//  Created by 许蒙静 on 2016/12/30.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import "PRecommendViewController.h"

@interface PRecommendViewController ()
@property (nonatomic, strong) UIImageView *aQRCodeImgV;
@end

@implementation PRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
    NSString *userIdTrue = [[NSUserDefaults standardUserDefaults] stringForKey:@"userIdTrue"];
    NSString *str = [NSString stringWithFormat:@"http://www.m-ebaby.com/front/account/app/register?recommendUserId=%@",userIdTrue];
    [self createQRCodeImageWithUrl:str];

}


- (void)createQRCodeImageWithUrl:(NSString *)url{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    
    
    //www.m-ebaby.com/front/account/app/pubreg
    NSData *data = [url dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    CIImage *outputImage = [filter outputImage];
    
    //UIImage *image = [UIImage imageWithCIImage:outputImage scale:20.0 orientation:UIImageOrientationUp];
    [self.aQRCodeImgV setImage:[self createNonInterpolatedUIImageFormCIImage:outputImage withSize:200]];
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

-(UIImageView *)aQRCodeImgV
{
    if (!_aQRCodeImgV) {
        _aQRCodeImgV = [[UIImageView alloc] init];
    }
    return _aQRCodeImgV;
}
- (void)initUI{
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(50);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(screenWidth- 30);
        make.height.mas_equalTo(screenWidth- 30);
    }];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"杭州鼎利网络科技有限公司@corporation";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = HexRGB(0x999999);
    label.font = [UIFont systemFontOfSize:11];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10);
        make.centerX.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(21);
    }];
    [backView addSubview:self.aQRCodeImgV];
    [self.aQRCodeImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(20);
    }];
    self.aQRCodeImgV.center = backView.center;
    self.aQRCodeImgV.size = CGSizeMake(backView.size.width - 40, backView.size.width - 40);
    
    UIImageView *imgV = [[UIImageView alloc] init];
    [imgV setImage:[UIImage imageNamed:@"icon_60"]];
    [backView addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.center.mas_equalTo(0);
    }];
    
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
