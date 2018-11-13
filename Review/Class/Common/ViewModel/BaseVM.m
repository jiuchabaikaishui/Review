//
//  BaseVM.m
//  Review
//
//  Created by 綦帅鹏 on 2018/11/13.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "BaseVM.h"

@implementation BaseVM

- (void)dealloc {
    DebugLog(@"%@销毁了", NSStringFromClass(self.class));
}

@end
