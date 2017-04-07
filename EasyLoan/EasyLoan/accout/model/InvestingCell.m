//
//  InvestingCell.m
//  EasyLoan
//
//  Created by ming yang on 16/8/1.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import "InvestingCell.h"
@interface InvestingCell ()

@property (nonatomic,strong)NSArray *titleArr;

@end
@implementation InvestingCell

-(NSArray *)titleArr{
    if (_titleArr == nil) {
        _titleArr = [NSArray arrayWithObjects:@"借款金额",@"年利率",@"投标进度", nil];
    }
    return _titleArr;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _number = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, screenWidth , 25)];
         [self setLabel:_number  TextAlignment:NSTextAlignmentLeft];

        _amount = [[UILabel alloc]initWithFrame:CGRectMake(0, _number.bottom, screenWidth / 3, _number.height)];
        [self setLabel:_amount TextAlignment:NSTextAlignmentCenter];
        
        _percent = [[UILabel alloc]initWithFrame:CGRectMake(_amount.right,_number.bottom, _amount.width, _number.height)];
        [self setLabel:_percent TextAlignment:NSTextAlignmentCenter];
        
        _totalPercent = [[UILabel alloc]initWithFrame:CGRectMake(_percent.right,_number.bottom, _amount.width, _number.height)];
        [self setLabel:_totalPercent TextAlignment:NSTextAlignmentCenter];
        for (int i = 0; i < 3; i++) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake( _amount.width * i, _amount.bottom, _amount.width, 20)];
            label.text = self.titleArr[i];
            label.font = SetFont(13);
            label.textColor = [UIColor darkGrayColor];
            label.textAlignment = NSTextAlignmentCenter;
            [self addSubview:label];
        }
    }
    return self;
}


-(void)setLabel:(UILabel*)label  TextAlignment:(NSTextAlignment)textAligment{
    label.font = SetFont(17);
    label.textColor = [UIColor darkGrayColor];
    label.textAlignment = textAligment;
    [self addSubview:label];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the view for the selected state
}

-(void)loadCellWithModel:(InvestingModel *)model{
    _number.text = [NSString stringWithFormat:@"编号 %@",model.no?model.no:@""];
    _amount.text = [NSString stringWithFormat:@"%@元",model.amount];
    _percent.text = [NSString stringWithFormat:@"%@%%",model.apr];
    _totalPercent.text =  [NSString stringWithFormat:@"%@%%",model.loan_schedule];
}

@end
