//
//  ConFunc.m
//  Review
//
//  Created by 綦帅鹏 on 2018/11/13.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "ConFunc.h"

@implementation ConFunc

+ (BOOL)blankOfStr:(NSString *)str {
    if (str == nil || str == NULL)
        return YES;
    
    if ([str isKindOfClass:[NSNull class]])
        return YES;
    
    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
        return YES;
    
    return NO;
}

@end
