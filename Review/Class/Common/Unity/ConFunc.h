//
//  ConFunc.h
//  Review
//
//  Created by 綦帅鹏 on 2018/11/13.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ConFunc : NSObject

/**
 字符串判空
 */
+ (BOOL)isBlank:(NSString *)str;

/**
 打印C语言数组

 @param arr 数组
 @param lenth 数组长度
 */
void printCArray(int arr[], int lenth);

/**
 响应者链
 */
+ (void)responderChainFormView:(UIResponder *)responder;

@end

NS_ASSUME_NONNULL_BEGIN

NS_ASSUME_NONNULL_END
