//
//  UIView+HUD.m
//  HHEnglish
//
//  Created by 付森 on 2018/12/29.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "UIView+HUD.h"
#import "MBProgressHUD.h"


static NSTimeInterval const kDefaultTime = 0.6;

@implementation UIView (HUD)

- (void)showToast:(NSString *)toast
{
    [self showToast:toast delay:kDefaultTime];
}

- (void)showToast:(NSString *)toast delay:(NSTimeInterval)delay
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self];
    
    if (hud == nil)
    {
        hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    }
    
    hud.mode = MBProgressHUDModeText;
    
    hud.label.text = toast;
    
    [hud hideAnimated:YES afterDelay:delay];
}

- (void)showNetToast:(NSString *)toast
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self];
    
    if (hud)
    {
        [hud hideAnimated:NO];
    }
    
    hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    
    hud.mode = MBProgressHUDModeIndeterminate;
    
    hud.label.text = toast;
}

- (void)hideToastAnimate:(BOOL)animate
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self];

    if (hud) {
        [hud hideAnimated:animate];
    }
}

@end
