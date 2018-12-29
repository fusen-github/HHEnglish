//
//  UIView+HUD.h
//  HHEnglish
//
//  Created by 付森 on 2018/12/29.
//  Copyright © 2018年 付森. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HUD)

- (void)showToast:(NSString *)toast;

- (void)showToast:(NSString *)toast delay:(NSTimeInterval)delay;

- (void)showNetToast:(NSString *)toast;

- (void)hideToastAnimate:(BOOL)animate;

@end
