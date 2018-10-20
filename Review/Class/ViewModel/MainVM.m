//
//  MainVM.m
//  Review
//
//  Created by apple on 2018/10/21.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "MainVM.h"
#import "CommonDefine.h"
#import "MainM.h"

@implementation MainVM

- (instancetype)init {
    if (self = [super init]) {
        self.title = @"iOS复习";
        self.tableViewVM = [QSPTableViewVM create:^(QSPTableViewVM *vm) {
            NSArray *arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ReviewList" ofType:@"plist"]];
            vm.addSectionVMCreate(CommonTableViewSectionVM.class, ^(CommonTableViewSectionVM *sectionVM){
                for (NSDictionary *dic in arr) {
                    sectionVM.addRowVMCreate(CommonTableViewCellVM.class, ^(CommonTableViewCellVM *cellVM){
                        cellVM.dataMSet([MainM mainMWithDic:dic]);
                    });
                }
            });
        }];
    }
    
    return self;
}

@end
