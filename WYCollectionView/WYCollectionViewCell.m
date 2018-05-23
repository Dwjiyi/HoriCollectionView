//
//  WYCollectionViewCell.m
//  WYCollectionView
//
//  Created by wy on 2018/5/22.
//  Copyright © 2018年 wy. All rights reserved.
//

#import "WYCollectionViewCell.h"

@implementation WYCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {

        self.layer.cornerRadius = 10.f;
        self.backgroundColor = [UIColor greenColor];
        self.clipsToBounds = YES;
        
        [self setupView];
    }
    return self;
    
}


- (void)setupView {
    
    // 这里用来初始化子控件
    
}





@end
