//
//  AccountCtl.m
//  EasyLoan
//
//  Created by ming yang on 16/6/22.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import "AccountCtl.h"
#import "SafeCenterCtl.h"
#import "ShareCtl.h"
#import "accountModel.h"
#import "LoginCtl.h"
#import "NSString+encryptDES.h"
#import "EquitableAssignmentCtl.h"
#import "MyInvestmentCtl.h"
#import "TransactionRecordCtl.h"
#import "VPImageCropperViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "AFNetworking.h"
#import "MyMessageCtl.h"
#import "WithDrawCtl.h"
#import "AppDelegate.h"
#import "HelpCenterViewController.h"
#import "AdviseViewController.h"
#import "RecommendViewController.h"
#define ORIGINAL_MAX_WIDTH 640.0f

@interface AccountCtl ()
<
UITableViewDelegate,
UITableViewDataSource,
UIActionSheetDelegate,
VPImageCropperDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate
>{
    UITableView *tableV;
    UIView *headerV;
    accountModel *model;
    
}
@property (nonatomic,strong)UIBarButtonItem *rightBarButton;

@property (nonatomic, strong) UIImageView *userImg;
//@property (nonatomic,strong)HeaderView *headerV;

@property (nonatomic,strong)NSArray *tableArr;

@property (nonatomic,strong)AppDelegate *appDelegate;

@end

@implementation AccountCtl


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLoginvalue) name:@"isLogin" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLoginvalue) name:@"notLogin" object:nil];
    
    [self changeLoginvalue];
    
     _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (UIBarButtonItem *)rightBarButton
{
    if (!_rightBarButton) {
        
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.frame = CGRectMake(0, 0, 15, 25);
        [rightButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        [rightButton setImage:[UIImage imageNamed:@"Login.png"] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(tuijian) forControlEvents:UIControlEventTouchUpInside];
        
        _rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    }
    return _rightBarButton;
}

-(void)tuijian{
    
    RecommendViewController *recommendVC = [[RecommendViewController alloc] initWithNibName:NSStringFromClass([RecommendViewController class]) bundle:nil];
    [self.navigationController pushViewController:recommendVC animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    NSLog(@"%ld",self.tabBarController.selectedIndex);
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   self.navigationItem.rightBarButtonItem = self.rightBarButton;
     [self setTableView];
}

- (void)changeLoginvalue{
    BOOL islogin = [UserManager onlyManager].isLogin;
    if (islogin == YES) {
        
        
        [self requestData];
        
          }else{
              
              LoginCtl* login = [LoginCtl alloc];
              
              login.type = 0;
              
              [self.navigationController pushViewController:login animated:YES];

    }
}


-(void)CreateHeaderView{
    
    headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 270)];
    
    headerV.backgroundColor = [UIColor whiteColor];
    
    
    [headerV addSubview:self.userImg];
    
    UILabel *userName = [[UILabel alloc]init];
    [self setLabel:userName WithFrame:CGRectMake(screenWidth/2 - 60, self.userImg.bottom + 3, 120, 25) Font:17 Text:model.name?model.name:@"未登录" addedSubView:headerV];
    
    UILabel *totalTitle = [[UILabel alloc]init];
    [self setLabel:totalTitle WithFrame:CGRectMake(screenWidth/2 - 60, userName.bottom+3, 120, 25) Font:17 Text:@"总资产（元)" addedSubView:headerV];
    
    UILabel *total = [[UILabel alloc]init];
    [self setLabel:total WithFrame:CGRectMake(screenWidth/2 - 90, totalTitle.bottom, 180, 34) Font:25 Text:model.amount?[NSString stringWithFormat:@"%@",model.amount]:@"0" addedSubView:headerV];
    
    UILabel *amountTitle = [[UILabel alloc]init];
    [self setLabel:amountTitle WithFrame:CGRectMake(0, total.bottom + 5, screenWidth/3-10, 25) Font:13 Text:@"已赚收益（元）" addedSubView:headerV];
    
    UILabel *balanceTitle = [[UILabel alloc]init];
    [self setLabel:balanceTitle WithFrame:CGRectMake(screenWidth/3 + 10, total.bottom + 5, screenWidth/3 - 10, 25) Font:13 Text:@"可用余额（元）" addedSubView:headerV];
    
    UILabel *frozen_amountTitle = [[UILabel alloc]init];
    [self setLabel:frozen_amountTitle WithFrame:CGRectMake(screenWidth/3 * 2 + 10, total.bottom + 5, screenWidth/3 -10, 25) Font:13 Text:@"待收总额（元）" addedSubView:headerV];
    
    UILabel *amount = [[UILabel alloc]init];
    [self setLabel:amount WithFrame:CGRectMake(0, amountTitle.bottom , screenWidth/3-10, 25) Font:20 Text:model.sum_income?[NSString stringWithFormat:@"%@",model.sum_income] :@"0.00" addedSubView:headerV];
    
    UILabel *balance = [[UILabel alloc]init];
    [self setLabel:balance WithFrame:CGRectMake(screenWidth/3 + 10, balanceTitle.bottom , screenWidth/3 - 10, 25) Font:20 Text:model.balance?[NSString stringWithFormat:@"%@",model.balance]:@"0.00" addedSubView:headerV];
    
    UILabel *frozen_amount = [[UILabel alloc]init];
    [self setLabel:frozen_amount WithFrame:CGRectMake(screenWidth/3 * 2, frozen_amountTitle.bottom , screenWidth/3 -10, 25) Font:20 Text:model.frozen_amount?[NSString stringWithFormat:@"%@",model.frozen_amount]:@"0.00" addedSubView:headerV];
    
    UILabel *segement = [[UILabel alloc]initWithFrame:CGRectMake(0, amount.bottom, screenWidth, 0.5)];
    segement.backgroundColor = [UIColor lightGrayColor];
    [headerV addSubview:segement];
    
    UIButton *topUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    topUpBtn.tag = 102;
    [topUpBtn setTitle:@"提现" forState:UIControlStateNormal];
    topUpBtn.backgroundColor = SetColor(235, 135, 62);
    [topUpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [topUpBtn setFrame:CGRectMake(8, segement.bottom + 8, screenWidth/2 -16, 44)];
    topUpBtn.layer.cornerRadius = 5;
    [topUpBtn addTarget:self action:@selector(touchAccountBtn:) forControlEvents:UIControlEventTouchUpInside];
    [headerV addSubview:topUpBtn];
    
    UIButton *withDraw = [UIButton buttonWithType:UIButtonTypeCustom];
    withDraw.tag = 101;
    [withDraw setTitle:@"充值" forState:UIControlStateNormal];
    withDraw.backgroundColor = SetColor(86, 176, 244);
    [withDraw setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [withDraw setFrame:CGRectMake(screenWidth/2+8, segement.bottom + 8, screenWidth/2 -16, 44)];
    withDraw.layer.cornerRadius = 5;
    [withDraw addTarget:self action:@selector(recharge) forControlEvents:UIControlEventTouchUpInside];
    [headerV addSubview:withDraw];
    
    tableV.tableHeaderView = headerV;
}
-(UIImageView *)userImg{
    if (!_userImg) {
        _userImg = [[UIImageView alloc]initWithFrame:CGRectMake(screenWidth/2 -30, 3, 60, 60)];
        
        _userImg.layer.cornerRadius = 30;
        _userImg.layer.masksToBounds = YES;
        
        //[_userImg setImage:[UIImage imageNamed:@"头像"]];
        [_userImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.m-ebaby.com%@",model.photo]] placeholderImage:[UIImage imageNamed:@"头像"]];
        
        _userImg.backgroundColor = [UIColor yellowColor];
        _userImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(postPhoto)];
        [_userImg addGestureRecognizer:tap];
    }else{
        [_userImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.m-ebaby.com%@",model.photo]] placeholderImage:[UIImage imageNamed:@"头像"]];
    }
    return _userImg;
}

-(void)recharge{
    WithDrawCtl *rechargeCtl = [[WithDrawCtl alloc]init];
    [self.navigationController pushViewController:rechargeCtl animated:YES];
}

-(void)touchAccountBtn:(UIButton *)btn{
    
    WebViewController *VC  =  [[WebViewController alloc]init];
    VC.type = 0;
    VC.tabTitle = @"提现";
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:UserId];
    NSString *url =  [NSString stringWithFormat:@"%@/front/account/app/withdraw?userId=%@",BUrl,userid];// http://www.m-ebaby.com
    
    VC.urlString = url;
    NSLog(@"%@",VC.urlString);
    [self.navigationController pushViewController:VC animated:YES];
}


-(void)setLabel:(UILabel*)label WithFrame:(CGRect)frame Font:(NSInteger)font Text:(NSString *)text addedSubView:(UIView *)view{
    label.frame = frame;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor darkGrayColor];
    label.font = SetFont(font);
    label.text = text;
    [view addSubview:label];
}

-(void)postPhoto{
    UIActionSheet* actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"请选择文件来源"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"照相机",@"本地相簿",nil];
    actionSheet.delegate = self;
    
    [actionSheet showInView:self.view];
}
#pragma mark--网络请求
-(void)requestData{
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:UserId];
    if (userId) {
        // NSString *desUserId = [NSString encrypt3DES:userId key:DESkey];
        NSDictionary *params = @{@"OPT":@"188",@"id":userId};
        [MyDataService requestParams:params complection:^(id result, NSError *error) {
            
                if (error == nil) {
                    if ([result[@"error"]  isEqualToString:@"-1"]) {
                       model = [[accountModel alloc]initWithDataDic:result];
                       

                        if ([model.isIps integerValue] == 0 && _appDelegate.isLps == NO) {
                            _appDelegate.isLps = YES;
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            WebViewController *VC  =  [[WebViewController alloc]init];
                            VC.type = 0;
                            NSString *url =  @"http://www.m-ebaby.com/front/account/app/openAccount?userId=";
                            NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:UserId];
                            VC.urlString = [NSString stringWithFormat:@"%@%@",url,userId];
                            VC.tabTitle = @"开户中心";
                            NSLog(@"%@",VC.urlString);
                            [self.navigationController pushViewController:VC animated:YES];
                        }
//                       [self.headerV loadHeaderViewWithAccountModel:model];
//                   dispatch_async(dispatch_get_main_queue(), ^{
//                       [self CreateHeaderView];
 //                  });
                        
                      //  [headerV setNeedsDisplay];
                        
                        [self CreateHeaderView];
                    }else if([result[@"error"]  isEqualToString:@"-3"] || [result[@"error"]  isEqualToString:@"-4"]) {
                       
                        [SVProgressHUD showErrorWithStatus:result[@"msg"]];
                    }else{
                        LoginCtl* login = [LoginCtl alloc];
                        
                        login.type = 0;
                        
                        [self.navigationController pushViewController:login animated:YES];
                        
                    }
                }else{
                    NSLog(@"%@",error);
                    
                    [SVProgressHUD showErrorWithStatus:@"请检查你的网络"];
                }

            
        }];
    }
    
}

-(void)setTableView{
    self.navigationItem.title = @"我的账户";
    self.navigationItem.leftBarButtonItem = nil;
    _tableArr = [NSArray arrayWithObjects:@"我的理财",@"我要借款",@"交易记录",@"安全中心",@"帮助中心", @"分享",@"退出登录",nil];//
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-64)];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.showsVerticalScrollIndicator = NO;
    tableV.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [self.view addSubview:tableV];
    
    UIView *clearView = [[UIView alloc]initWithFrame:CGRectMake(0, -1, tableV.frame.size.width, 22)];
    clearView.backgroundColor= [UIColor clearColor];
    [tableV setTableFooterView:clearView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
        return _tableArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        UIImageView *titleImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 30, 30)];
        UIView *V = [[UIView alloc]initWithFrame:CGRectMake(0, 0, cell.contentView.frame.size.width, 0)];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(titleImg.width + titleImg.left+10, 10, 100, 20)];
        
        V.backgroundColor = SetColor(245, 245, 245);
        [cell.contentView addSubview:V];
        
        titleImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"my%ld",indexPath.row+1]];
        label.text = _tableArr[indexPath.row];
        [cell.contentView addSubview:titleImg];
        
        label.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:label];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;

    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
        if (indexPath.row == 0) {
            MyInvestmentCtl *myInvestCtl = [MyInvestmentCtl new];
            [self.navigationController pushViewController:myInvestCtl animated:YES];
        }else if (indexPath.row == 1){
            WebViewController *VC  =  [[WebViewController alloc]init];
            VC.type = 0;
            NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:UserId] ? [[NSUserDefaults standardUserDefaults] objectForKey:UserId]:@"";
            NSString *url = [NSString stringWithFormat: @"%@/front/account/app/index?userId=%@",BUrl,userId] ;
            NSLog(@"%@",url);
            
            
            VC.urlString = [NSString stringWithFormat:@"%@%@",url,userId];
            VC.tabTitle = @"我要借款";
            NSLog(@"%@",VC.urlString);
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if (indexPath.row == 2){
            TransactionRecordCtl *TVC =[TransactionRecordCtl new];
            [self.navigationController pushViewController:TVC animated:YES];
            
        }else if (indexPath.row == 3){
            SafeCenterCtl *safeCenter = [[SafeCenterCtl alloc]init];
            safeCenter.isLps = [model.isIps integerValue] == 0 ? NO : YES;
            [self.navigationController pushViewController:safeCenter animated:YES];
            
        }else if(indexPath.row == 4){
            HelpCenterViewController *helpCenterVC = [[HelpCenterViewController alloc] init];
            [self.navigationController pushViewController:helpCenterVC animated:YES];

        }else if(indexPath.row == 5){
            ShareCtl *shareVC = [[ShareCtl alloc] init];
            [self.navigationController pushViewController:shareVC animated:YES];
            
        }else if(indexPath.row == 6){
            LoginCtl* login = [LoginCtl alloc];
            
            login.type = 0;
            
            [self.navigationController pushViewController:login animated:YES];
//            AdviseViewController *adviseVC = [[AdviseViewController alloc] initWithNibName:NSStringFromClass([AdviseViewController class]) bundle:nil];
//            [self.navigationController pushViewController:adviseVC animated:YES];
        }else{
            LoginCtl* login = [LoginCtl alloc];
            login.type = 0;
            [self.navigationController pushViewController:login animated:YES];
        }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

//改变cell颜色
- (void) tableView: (UITableView *) tableView  willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor whiteColor];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 45;
}

#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
   
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        //+ (void)Request:(NSString *)urlStr with:(NSDictionary *)params with:(completionBlock)susses  withError:(completionBlock)error
        NSData *data;
        if (UIImagePNGRepresentation(editedImage) == nil) {
            
            data = UIImageJPEGRepresentation(editedImage, 1);
            
        } else {
            data = UIImagePNGRepresentation(editedImage);
        }
        NSString *base64String = [data base64EncodedStringWithOptions:0];
        //上传图片
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat =@"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        fileName = @"aaa";
        NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:UserId];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValue:@"147" forKey:@"OPT"];
        [params setValue:userId forKey:@"id"];
        [params setValue:@"1" forKey:@"type"];
        [params setValue:@"png" forKey:@"fileExt"];
        [params setValue:base64String forKey:@"imgStr"];
        
        
        [MyDataService upLoadImgmeWithParameters:params imageData:data success:^(id successObj) {
            [self.userImg setImage:editedImage];
        } fail:^(id failObj) {
            
        }];
        
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // 拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
        
    } else if (buttonIndex == 1) {
        // 从相册中选取
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        // present the cropper view controller
        VPImageCropperViewController *imgCropperVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imgCropperVC.delegate = self;
        [self presentViewController:imgCropperVC animated:YES completion:^{
            // TO DO
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}



@end
