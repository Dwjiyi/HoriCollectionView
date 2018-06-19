//
//  WYHomeController.m
//  WYCollectionView
//
//  Created by 王宇 on 2018/5/22.
//  Copyright © 2018年 wy. All rights reserved.
//

#import "WYHomeController.h"
#import "WYCollectionView.h"

@implementation WYHomeController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupCollectionView];
}

- (void)setupCollectionView {
    
    /* 水平滑动的collectionView
     * 滑动过程中，前面显示5px，中间全显示，后面显示一部分
     */
    
    CGFloat viewHeight = 120;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(290, 100);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
    flowLayout.minimumLineSpacing = 10;
    
    WYCollectionView *collectionView = [[WYCollectionView alloc]initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, viewHeight) collectionViewLayout:flowLayout];
//    collectionView.pagingEnabled = YES;  // 设置分页滑动的width是SCREEN_WIDTH,不符合要求
    collectionView.scrollEnabled = NO;    // 设置分页行不通，改用手势控制滑动，需要把滑动交互关掉
    collectionView.contentSize = CGSizeMake((290+10)*5+15, 0);  
 
    [self.view addSubview:collectionView];
    
}


@end
