//
//  SampleBaseViewController.m
//  Review
//
//  Created by apple on 17/5/31.
//  Copyright © 2017年 QSP. All rights reserved.
//

#import "SampleBaseViewController.h"

@interface SampleBaseViewController ()

@end

@implementation SampleBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    if (!self.title) {
        self.title = @"示例演示";
    }
}

@end
