//
//  AdviseViewController.m
//  EasyLoan
//
//  Created by 许蒙静 on 2016/11/21.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import "AdviseViewController.h"

@interface AdviseViewController ()
<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *commintBtn;
@property (weak, nonatomic) IBOutlet UIButton *serviceBtn;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *placehoderLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation AdviseViewController

-(void)awakeFromNib{
    [super awakeFromNib];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.commintBtn.layer.cornerRadius = 3;
    self.serviceBtn.layer.cornerRadius = 3;
    self.textView.delegate = self;
    self.title = @"意见反馈";
    self.navigationItem.leftBarButtonItem = self.leftBarButton;
    
}
- (IBAction)commitAction:(id)sender {
    if (self.textView.text.length==0) {
        [SVProgressHUD showImage:nil status:@"意见反馈不能为空"];
    }else{
        [SVProgressHUD showImage:nil status:@"反馈成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (IBAction)phoneAction:(id)sender {
//    NSMutableString str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"186xxxx6979"];
//    UIWebView callWebview = [[UIWebView alloc] init];
//    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
//    [self.view addSubview:callWebview];
    [self.view endEditing:YES];
    NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"057187221605"];
    // NSLog(@"str======%@",str);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}

#pragma mark --textviewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView{
    //self.placehoderLabel.hidden = YES;
}

-(void)textViewDidChange:(UITextView *)textView{
    NSInteger length = textView.text.length;
    if (length>0) {
        self.placehoderLabel.hidden = YES;
    }else{
        self.placehoderLabel.hidden = NO;
    }

    if (length >= 300) {
        
        textView.text = [textView.text substringToIndex:300];
        self.countLabel.text = @"300/300字";
        
    }else{
        self.countLabel.text = [NSString stringWithFormat:@"%ld/300字",length];
    }
    
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length>0) {
        self.placehoderLabel.hidden = YES;
    }else{
        self.placehoderLabel.hidden = NO;
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textView resignFirstResponder];
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
