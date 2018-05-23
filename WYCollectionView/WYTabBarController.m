//
//  WYTabBarController.m
//  WYCollectionView
//
//  Created by wy on 2018/5/22.
//  Copyright © 2018年 wy. All rights reserved.
//

#import "WYTabBarController.h"
#import "WYHomeController.h"
#import "WYNavigationController.h"

@interface WYTabBarController ()

@end

@implementation WYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildVC];
}



- (void)setupChildVC {

    WYHomeController *homeController = [[WYHomeController alloc]init];
    homeController.title = @"首页";
    // 设置选中未选中状态图片
    homeController.tabBarItem.image = [UIImage imageNamed:@"tabbar_news"];
    homeController.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_news_hl"];
    
    
    WYNavigationController *nav = [[WYNavigationController alloc]initWithRootViewController:homeController];
    [self addChildViewController:nav];
     
}



@end
