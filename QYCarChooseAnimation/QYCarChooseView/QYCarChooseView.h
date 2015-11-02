//
//  CarChooseView.h
//  BlueRhino
//
//  Created by 千叶 on 15/4/1.
//  Copyright (c) 2015年 qianye. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDeviceWidth  [UIScreen mainScreen].bounds.size.width
#define KDeviceHeight [UIScreen mainScreen].bounds.size.height

@protocol QYCarChooseDelegate <NSObject>

@required
- (void)showDetailCarTypeWithIndex:(int)index;

@end

@interface QYCarChooseView : UIView<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) NSArray *dataList;
@property (strong, nonatomic) NSArray *carNameList;
@property (strong, nonatomic) UICollectionView *chooseDriverView;
@property (assign, nonatomic) id<QYCarChooseDelegate> delegate;
@end
