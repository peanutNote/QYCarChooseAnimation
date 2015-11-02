//
//  CarChooseView.m
//  BlueRhino
//
//  Created by 千叶 on 15/4/1.
//  Copyright (c) 2015年 qianye. All rights reserved.
//

#import "QYCarChooseView.h"
#import "LineLayout.h"
#import "QYCarViewCell.h"
#import "UIViewExt.h"

@implementation QYCarChooseView
{
    UICollectionView *_chooseDriverView;
    int _currentIndex;
    
    
    UIButton *_leftBtn;
    UIButton *_rightBtn;
    
    
    int _index;
    
    // 车名标签
    UILabel *_label1;
    UILabel *_label2;
    UILabel *_label3;
    
    // 默认选中图片颜色只设置一次
    BOOL _isInitSelected;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self _initWihtViews];
    }
    return self;
}

// 创建视图
- (void)_initWihtViews
{
    LineLayout *flowLayout = [[LineLayout alloc] init];
    _chooseDriverView = [[UICollectionView alloc] initWithFrame:CGRectMake((kDeviceWidth - 200) / 2.0, 34, 200, 64) collectionViewLayout:flowLayout];
    _chooseDriverView.delegate = self;
    _chooseDriverView.dataSource = self;
    _chooseDriverView.backgroundColor = [UIColor clearColor];
    _chooseDriverView.showsHorizontalScrollIndicator = NO;
    _chooseDriverView.bounces = NO;
    _chooseDriverView.decelerationRate = UIScrollViewDecelerationRateFast;
    [self addSubview:_chooseDriverView];
    
    // 车名标签
    _label1 = [[UILabel alloc] initWithFrame:CGRectMake(_chooseDriverView.left - 10, 5, 62, 20)];
    _label1.textAlignment = NSTextAlignmentCenter;
    _label1.font = [UIFont systemFontOfSize:12];
    _label1.textColor = [UIColor lightGrayColor];
    [self addSubview:_label1];
    _label2 = [[UILabel alloc] initWithFrame:CGRectMake(_label1.right, 5, 66, 20)];
    _label2.center = CGPointMake(_chooseDriverView.center.x, _label2.center.y);
    _label2.textAlignment = NSTextAlignmentCenter;
    _label2.font = [UIFont systemFontOfSize:12];
    _label2.textColor = [UIColor colorWithRed:81.0/255 green:196.0/255 blue:212.0/255 alpha:1.0];
    [self addSubview:_label2];
    _label3 = [[UILabel alloc] initWithFrame:CGRectMake(_label2.right + 15, 5, 60, 20)];
    _label3.textAlignment = NSTextAlignmentCenter;
    _label3.font = [UIFont systemFontOfSize:12];
    _label3.textColor = [UIColor lightGrayColor];
    [self addSubview:_label3];
    
    [_chooseDriverView registerClass:[QYCarViewCell class] forCellWithReuseIdentifier:@"cell_car"];
    
    // 左右两边的按钮
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftBtn.frame = CGRectMake(0, 36 + (62 - 46) / 2, 46, 46);
    [_leftBtn setImage:[UIImage imageNamed:@"main_carChoose_right"] forState:UIControlStateNormal];
    _leftBtn.hidden = YES;
    [_leftBtn addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_leftBtn];
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.frame = CGRectMake(kDeviceWidth - 46, 36 + (62 - 46) / 2, 46, 46);
    [_rightBtn setBackgroundImage:[UIImage imageNamed:@"main_carChoose_left"] forState:UIControlStateNormal];
    _rightBtn.hidden = YES;
    [_rightBtn addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_rightBtn];
    
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"main_sanjiao"]];
    img.frame = CGRectMake(kDeviceWidth/2-8, self.bottom-10, 16, 10);
    [self addSubview:img];
}

- (void)setDataList:(NSArray *)dataList
{
    if (_dataList != dataList) {
        _dataList = dataList;
    }
    if (dataList.count > 1) {
        _currentIndex = 1;
        _index = 1;
        [_chooseDriverView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }else {
        _currentIndex = 0;
        _index = 0;
    }
    
    if (_dataList.count > 3) {
        _leftBtn.hidden = NO;
    }else {
        _leftBtn.hidden = YES;
    }
    
}


- (void)setCarNameList:(NSArray *)carNameList
{
    if (_carNameList != carNameList) {
        _carNameList = carNameList;
    }
    if (_carNameList.count == 1) {
        _label1.text = @"";
        _label2.text = [carNameList lastObject];
        _label3.text = @"";
    }else if (_carNameList.count == 2) {
        _label1.text = carNameList[0];
        _label2.text = carNameList[1];
        _label3.text = @"";
    }else {
        if (carNameList.count!=0) {
            _label1.text = carNameList[0];
            _label2.text = carNameList[1];
            _label3.text = carNameList[2];
        }
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QYCarViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_car" forIndexPath:indexPath];
    cell.carImageArray = _dataList[indexPath.item];
    cell.carImageBtn.selected = NO;
    if (_dataList.count > 1 && indexPath.item == 1 && !_isInitSelected) {
        cell.carImageBtn.selected = YES;
        _isInitSelected = YES;
    }else if (_dataList.count <= 1 && !_isInitSelected){
        cell.carImageBtn.selected = YES;
        _isInitSelected = YES;
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(64, 64);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_currentIndex != indexPath.item) {
        // 将点击的视图移动到屏幕中间
        [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        // 重新记录当前视图下标
        _currentIndex = (int)indexPath.row;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets edgeInset = UIEdgeInsetsMake(0, (_chooseDriverView.width - 64) / 2, 0, (_chooseDriverView.width - 64) / 2.0);
    return edgeInset;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offSetX = scrollView.contentOffset.x;
    _currentIndex = offSetX / 76;
    
    if (_currentIndex != _index && (int)offSetX % 76 == 0) {
        QYCarViewCell *FontCell = (QYCarViewCell *)[_chooseDriverView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:_index inSection:0]];
        FontCell.carImageBtn.selected = NO;
        QYCarViewCell *cell = (QYCarViewCell *)[_chooseDriverView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:_currentIndex inSection:0]];
        cell.carImageBtn.selected = YES;
        _index = _currentIndex;
        
        
        // 改变车名标签
        _label2.text = _carNameList[_currentIndex];
        if (_currentIndex - 1 >= 0) {
            _label1.text = _carNameList[_currentIndex - 1];
        }else {
            _label1.text = @"";
        }
        if (_currentIndex + 1 <= _carNameList.count - 1) {
            _label3.text = _carNameList[_currentIndex + 1];
        }else {
            _label3.text = @"";
        }
        
        // 调用代理传值
        if ([self.delegate respondsToSelector:@selector(showDetailCarTypeWithIndex:)]) {
            [self.delegate showDetailCarTypeWithIndex:_currentIndex];
        }
    }
    
    if (offSetX <= 76) {
        _rightBtn.hidden = YES;
    }
    if (offSetX >= (_dataList.count - 2) * 76) {
        _leftBtn.hidden = YES;
    }
}


- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item < _currentIndex) {
        _rightBtn.hidden = NO;
    }
    if (indexPath.item > _currentIndex) {
        _leftBtn.hidden = NO;
    }
    QYCarViewCell *carCell = (QYCarViewCell *)cell;
    carCell.carImageBtn.selected = NO;
}

// 该方法为iOS8以后才可以使用的方法(坑)
//- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.item == 0) {
//        _rightBtn.hidden = YES;
//    }else if (indexPath.item == _dataList.count - 1) {
//        _leftBtn.hidden = YES;
//    }
//}


#pragma mark - 按钮点击事件
- (void)leftAction:(UIButton *)sender
{
    _currentIndex++;
    [_chooseDriverView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (void)rightAction:(UIButton *)sender
{
    _currentIndex--;
    [_chooseDriverView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

@end
