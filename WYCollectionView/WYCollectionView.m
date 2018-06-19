//
//  WYCollectionView.m
//  WYCollectionView
//
//  Created by wy on 2018/5/22.
//  Copyright © 2018年 wy. All rights reserved.
//

#import "WYCollectionView.h"
#import "WYCollectionViewCell.h"

#define Count 5

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
    
    CGFloat itemWidth = 290.0;
    CGFloat margin = 10.0;
    NSInteger width = itemWidth+margin;
    
    // 计算当前滑动的cell的索引
    CGPoint point = [gesture locationInView:self];
    NSInteger index = (point.x-15) / width;
    NSLog(@"index:%ld x:%lf contentOffset:%lf",index,point.x,self.contentOffset.x);
    
    // 将点转化为window上的点，计算该点在当前屏幕上的x坐标
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGPoint windowPoint = [self convertPoint:point toView:window];
    NSInteger x = (NSInteger)windowPoint.x % (NSInteger)SCREEN_WIDTH;
    
    if (gesture.direction == UISwipeGestureRecognizerDirectionLeft){
        
        // 右划特殊考虑最后一个
        if (index <= Count-2 && x < width+15){
            index = index + 1;
        }
   

    } else if (swipeGesture.direction == UISwipeGestureRecognizerDirectionRight){
        
        // 左划特殊考虑第一个和倒数第二个
        if (index > 0){
            
            if (self.contentOffset.x > width*(Count-2) && index == Count -2) {
                NSLog(@"这是在最后一页左划倒数第二个item,index不变");
            } else {
                
                if (x <= 15){
                    
                }else if ((x > 15 && x < width+15)||index == 1) {
                    index = index - 1;
                } else {
                    index = index - 2;
                }
            }
        }
    }
    
    if (index == Count-1) { // 往最后一个页面滑动
        
        [UIView animateWithDuration:0.3 animations:^{
            [self setContentOffset:CGPointMake(width*index-(SCREEN_WIDTH-15-itemWidth-15), 0) animated:YES];
        }];
    } else {
        
        [UIView animateWithDuration:0.3 animations:^{
            [self setContentOffset:CGPointMake(width*index, 0) animated:YES];
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
