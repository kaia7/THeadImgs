//
//  ViewController.m
//  THeadImgs
//
//  Created by ITD on 2017/3/24.
//  Copyright © 2017年 ITD. All rights reserved.
//

#import "ViewController.h"
#import "CreatGroupAvatar.h"

#define DeviceWidth [UIScreen mainScreen].bounds.size.width
#define DeviceHeight [UIScreen mainScreen].bounds.size.height
const CGFloat canvasViewSideLength = 100.0f;

static const CGFloat THeadImgLength = 100.0f;      //头像的长和宽
static const CGFloat THeadImgRatio = 10.0f;

@interface ViewController () {
    CGFloat _beginningY;
    CGFloat _canvasViewMargin;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _canvasViewMargin = (DeviceWidth - canvasViewSideLength * 3) / 4;
    _beginningY = (DeviceHeight - canvasViewSideLength * 3 - _canvasViewMargin * 2) / 2;
    

//    NSArray *imgNames = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
    
    NSArray *imgNames = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1490344686500&di=9d25111a6e55f1f43bc5ae21e9ba10f2&imgtype=0&src=http%3A%2F%2Fd.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2F72f082025aafa40fe871b36bad64034f79f019d4.jpg",@"http://pic6.huitu.com/res/20130116/84481_20130116142820494200_1.jpg",@"http://img4.imgtn.bdimg.com/it/u=4240647030,871786634&fm=206&gp=0.jpg",@"http://img2.imgtn.bdimg.com/it/u=2003541228,1180616582&fm=206&gp=0.jpg",@"http://img5.imgtn.bdimg.com/it/u=1400488033,2241248236&fm=206&gp=0.jpg",@"1",@"2",@"7"];


    //群头像
    UIImageView *THeadimageView = [[UIImageView alloc] initWithFrame:CGRectMake(100,200,THeadImgLength,THeadImgLength)];
    THeadimageView.layer.cornerRadius = THeadImgRatio;
    THeadimageView.layer.masksToBounds = YES;
    THeadimageView.backgroundColor = [UIColor colorWithWhite:0.839 alpha:1.000];
//    [self.view addSubview:THeadimageView];

//    UIImageView *coverImage = [[StitchingImage alloc] stitchingOnImageView:THeadimageView withImageViews:imgNames];
//    [self.view addSubview:coverImage];
    

    

    [self createCanvasViews];

}

- (void) createCanvasViews {
    int maxRow = 3;
    int maxColumn = 3;
    
      NSArray *mary = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1490344686500&di=9d25111a6e55f1f43bc5ae21e9ba10f2&imgtype=0&src=http%3A%2F%2Fd.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2F72f082025aafa40fe871b36bad64034f79f019d4.jpg",@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1794894692,1423685501&fm=117&gp=0.jpg",@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1350614941,725003865&fm=117&gp=0.jpg",@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1066522,2097323916&fm=117&gp=0.jpg",@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3432487329,2901563519&fm=117&gp=0.jpg",@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1502327020,2968128604&fm=117&gp=0.jpg",@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2631395475,3048571251&fm=117&gp=0.jpg",@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1314391329,2424732330&fm=117&gp=0.jpg",@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1425317030,4113620941&fm=117&gp=0.jpg"];
    for (int i = 0; i < 9; i++) {
        int row = floor((float)i / maxRow);
        int column = i % maxColumn;
        CGFloat originX = _canvasViewMargin + column * canvasViewSideLength + column * _canvasViewMargin;
        CGFloat originY = _beginningY + row * canvasViewSideLength + row * _canvasViewMargin;
        NSArray *ary = [mary subarrayWithRange:NSMakeRange(0,i+1)];
        UIImageView *canvasView = [[UIImageView alloc] initWithFrame:CGRectMake(originX, originY, canvasViewSideLength, canvasViewSideLength)];
        canvasView.layer.cornerRadius = 5;
        canvasView.layer.masksToBounds = YES;
        canvasView.backgroundColor = [UIColor colorWithWhite:0.839 alpha:1.000];
        
        
        [CreatGroupAvatar greateGroupAvatar:ary finished:^(NSData *groupAvatar) {
            canvasView.image = [UIImage imageWithData:groupAvatar];
        }];
        
        [self.view addSubview:canvasView];
    }
}












@end
