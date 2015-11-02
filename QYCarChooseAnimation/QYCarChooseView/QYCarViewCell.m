//
//  CarViewCell.m
//  BlueRhino
//
//  Created by 千叶 on 15/4/3.
//  Copyright (c) 2015年 qianye. All rights reserved.
//

#import "QYCarViewCell.h"

@implementation QYCarViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _carImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _carImageBtn.frame = CGRectMake(16, 16, 32, 32);
        _carImageBtn.userInteractionEnabled = NO;
        [self.contentView addSubview:_carImageBtn];
    }
    return self;
}


- (void)setCarImageArray:(NSArray *)carImageArray
{
    if (_carImageArray != carImageArray) {
        _carImageArray = carImageArray;
    }
    UIImage *temp1 = [UIImage imageNamed:carImageArray[0]];
    if (temp1 ==nil) {
        temp1 = [UIImage imageNamed:@"main_carType_99"];
    }
    UIImage *temp2 = [UIImage imageNamed:carImageArray[1]];
    if (temp2 ==nil) {
        temp2 = [UIImage imageNamed:@"main_carTypeColor_99"];
    }
    [_carImageBtn setImage:temp1 forState:UIControlStateNormal];
    [_carImageBtn setImage:temp2 forState:UIControlStateSelected];
}

@end
