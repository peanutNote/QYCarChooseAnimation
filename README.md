## QYCarChooseAnimation
* 一种3D选择车型（也可以是任意其他类型）的动画效果

## 如何使用QYCarChooseAnimation
* 将QYCarChooseView文件添加到项目中，导入头文件`#import "QYCarChooseView.h"`

## 具体说明
* 实现：使用了UICollectionView，以及官方提供的布局文件“LineLayout（有稍些修改）”主要用来实现3D滑动效果
* 使用：
* 
```objc
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
```