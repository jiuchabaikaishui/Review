//
//  LoadingClass.m
//  Review
//
//  Created by apple on 2019/8/30.
//  Copyright © 2019 QSP. All rights reserved.
//

#import "LoadingClass.h"
#import "MBProgressHUD.h"

@implementation LoadingClass


+ (void)loadingToView:(UIView *)view {
    UIView *v = view;
    if (v == nil) {
        v = [UIApplication sharedApplication].keyWindow;
    }
    [MBProgressHUD hideHUDForView:v animated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:v animated:YES];
    hud.label.text = @"加载中…";
}
+ (void)showMessage:(NSString *)mesagge toView:(UIView *)view {
    UIView *v = view;
    if (v == nil) {
        v = [UIApplication sharedApplication].keyWindow;
    }
    [MBProgressHUD hideHUDForView:v animated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:v animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.userInteractionEnabled = NO;
    hud.label.text = mesagge;
    
    [hud hideAnimated:YES afterDelay:2];
}
+ (void)hideFromView:(UIView *)view {
    UIView *v = view;
    if (v == nil) {
        v = [UIApplication sharedApplication].keyWindow;
    }
    
    [MBProgressHUD hideHUDForView:v animated:YES];
}

@end
