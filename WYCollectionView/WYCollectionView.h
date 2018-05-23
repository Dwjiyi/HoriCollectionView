//
//  WYCollectionView.h
//  WYCollectionView
//
//  Created by wy on 2018/5/22.
//  Copyright © 2018年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WYCollectionViewDelegate <NSObject>


@end




@interface WYCollectionView : UICollectionView


@property (nonatomic, weak) id <WYCollectionViewDelegate>agent;

@end
