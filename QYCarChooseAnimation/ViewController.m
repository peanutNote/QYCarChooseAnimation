//
//  ViewController.m
//  QYCarChooseAnimation
//
//  Created by qianye on 15/11/2.
//  Copyright © 2015年 qianye. All rights reserved.
//

#import "ViewController.h"
#import "QYCarChooseView.h"

@interface ViewController ()<QYCarChooseDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *carTypeArray = @[@"car0",@"car1",@"car2",@"car3",@"car4",@"car5",@"car6"];
    
    NSArray *carCountArray = @[@1,@2,@3,@4,@5,@6,@7];
    
    NSMutableArray *carPicArray = [NSMutableArray array];
    for (NSNumber *carStr in carCountArray) {
        NSString *picStr1 = [NSString  stringWithFormat:@"main_carType_%@",carStr];
        
        NSString *picStr2 = [NSString  stringWithFormat:@"main_carTypeColor_%@",carStr];
        [carPicArray addObject:@[picStr1,picStr2]];
    }
    
    QYCarChooseView *driverChooseView = [[QYCarChooseView alloc] initWithFrame:CGRectMake(0, 200, kDeviceWidth, 110)];
    driverChooseView.backgroundColor = [UIColor whiteColor];
    driverChooseView.delegate = self;
    driverChooseView.dataList = carPicArray;
    driverChooseView.carNameList = carTypeArray;
    [self.view addSubview:driverChooseView];
}
#pragma mark - 车辆选择代理方法
- (void)showDetailCarTypeWithIndex:(int)index
{
    NSLog(@"%d",index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
