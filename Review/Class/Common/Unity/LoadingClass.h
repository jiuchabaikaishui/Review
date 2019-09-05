//
//  LoadingClass.h
//  Review
//
//  Created by apple on 2019/8/30.
//  Copyright © 2019 QSP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoadingClass : NSObject

+ (void)loadingToView:(UIView *)view;
+ (void)showMessage:(NSString *)mesagge toView:(UIView *)view;
+ (void)hideFromView:(UIView *)view;

@end

NS_ASSUME_NONNULL_BEGIN

NS_ASSUME_NONNULL_END
