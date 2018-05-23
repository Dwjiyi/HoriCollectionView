//
//  WYCollectionView.m
//  WYCollectionView
//
//  Created by wy on 2018/5/22.
//  Copyright © 2018年 wy. All rights reserved.
//

#import "WYCollectionView.h"
#import "WYCollectionViewCell.h"

static NSInteger Count = 5;

static NSString *CellIdentiifer = @"CellIdentiifer";

@interface WYCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>


@end


@implementation WYCollectionView


- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        self.clipsToBounds = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.backgroundColor = [UIColor redColor];
        
        [self addGesture];
        [self registerClass:[WYCollectionViewCell class] forCellWithReuseIdentifier:CellIdentiifer];
    }
    return self;
}


- (void)addGesture {
    
    UISwipeGestureRecognizer * swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeGesture:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer * swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeGesture:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipeLeft];
    
}

- (void)handleSwipeGesture:(UISwipeGestureRecognizer *)swipeGesture {
    
    UISwipeGestureRecognizer *gesture = swipeGesture;
    
    CGPoint point = [gesture locationInView:self];
    NSInteger index = (point.x-15) / (290+10); // 计算当前滑动的cell的索引
    NSLog(@"index:%ld x:%lf",index,point.x);
    
    NSInteger width = 290+10;
    
    if (gesture.direction == UISwipeGestureRecognizerDirectionLeft && index <= Count-2){ // 右滚
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        // 1.将点转化为window上的点
        CGPoint windowPoint = [self convertPoint:point toView:window];
        // 2.计算该点在当前屏幕上的x坐标
        NSInteger x = (NSInteger)windowPoint.x % (NSInteger)SCREEN_WIDTH;
        // 3.如果该点在屏幕上第一个cell上，索引+1，右滚到第二个cell上;如果该点在屏幕第二个cell上，则索引不+，右滚到第二个cell上
        if (x < width+15) index = index + 1;
        
    } else if (swipeGesture.direction == UISwipeGestureRecognizerDirectionRight && index > 0){ // 左滚
        
        index = index - 1;
    }
    
    if (index == Count-1) { // 往最后一个页面滑动
        
        [UIView animateWithDuration:0.3 animations:^{
            
            [self setContentOffset:CGPointMake(width*index-(SCREEN_WIDTH-15-290-15), 0) animated:YES];
            
        } completion:^(BOOL finished) {
            
        }];
        
    } else {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            [self setContentOffset:CGPointMake(width*index, 0) animated:YES];
            
        } completion:^(BOOL finished) {
            
        }];
    }
    
    
}



#pragma mark - collection view delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return Count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WYCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentiifer forIndexPath:indexPath];
    return cell;
}


#pragma mark - collection view data source
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"点击我了，我是第%ld个",indexPath.row);
    
}








@end
