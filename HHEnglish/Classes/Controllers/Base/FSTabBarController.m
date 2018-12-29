//
//  FSTabBarController.m
//  HHEnglish
//
//  Created by 付森 on 2018/12/29.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSTabBarController.h"
#import "FSHomeViewController.h"
#import "FSReciteViewController.h"
#import "FSCheckViewController.h"
#import "FSMineViewController.h"


@interface FSTabBarController ()

@end

@implementation FSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array =
  @[@{@"className":@"FSHomeViewController", @"imageName":@"tabbar_home", @"title":@"首页"},
    @{@"className":@"FSReciteViewController", @"imageName":@"tabbar_message_center", @"title":@"背书"},
    @{@"className":@"FSCheckViewController", @"imageName":@"tabbar_discover", @"title":@"自测"},
    @{@"className":@"FSMineViewController", @"imageName":@"tabbar_profile", @"title":@"我的"}];
    
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    for (NSDictionary *dict in array)
    {
        NSString *className = [dict objectForKey:@"className"];
        
        Class classObj = NSClassFromString(className);
        
        NSString *title = [dict objectForKey:@"title"];
        
        NSString *imageName = [dict objectForKey:@"imageName"];
        
        UIViewController *controller = [[classObj alloc] init];
        
        controller.title = title;
        
        controller.tabBarItem.image = [UIImage imageNamed:imageName];
        
        imageName = [imageName stringByAppendingString:@"_selected"];
        
        UIImage *image = [UIImage imageNamed:imageName];
        
        controller.tabBarItem.selectedImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        
        [tmpArray addObject:navController];
    }
    
    self.viewControllers = tmpArray;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    NSLog(@"%s", __func__);
    
    NSMutableDictionary *normalAttr = [NSMutableDictionary dictionary];
    
    [normalAttr setObject:[UIFont systemFontOfSize:12] forKey:NSFontAttributeName];
    
    [normalAttr setObject:UIColorFromRGB(0xC5C5C5) forKey:NSForegroundColorAttributeName];
    
    NSMutableDictionary *selectAttr = [NSMutableDictionary dictionary];
    
    [selectAttr setObject:[UIFont systemFontOfSize:12] forKey:NSFontAttributeName];
    
    [selectAttr setObject:UIColorFromRGB(0xFF8201) forKey:NSForegroundColorAttributeName];
    
    for (UIViewController *controller in self.viewControllers)
    {
        [controller.tabBarItem setTitleTextAttributes:normalAttr forState:UIControlStateNormal];
        
        [controller.tabBarItem setTitleTextAttributes:selectAttr forState:UIControlStateSelected];
    }
    
}


@end
