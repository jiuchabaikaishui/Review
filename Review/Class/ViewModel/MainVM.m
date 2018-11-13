//
//  MainVM.m
//  Review
//
//  Created by apple on 2018/10/21.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "MainVM.h"
#import "CommonDefine.h"
#import "MainCellM.h"

@implementation MainVM

- (instancetype)init {
    if (self = [super init]) {
        self.title = @"iOS复习";
        self.tableViewVM = [QSPTableViewVM create:^(QSPTableViewVM *vm) {
            NSArray *arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ReviewList" ofType:@"plist"]];
            vm.addSectionVMCreate(CommonTableViewSectionVM.class, ^(CommonTableViewSectionVM *sectionVM){
                sectionVM.dataMCreate(CommonM.class, ^(CommonM *model){
                    model.titleSet(@"基础");
                });
                for (NSDictionary *dic in arr) {
                    sectionVM.addRowVMCreate(CommonTableViewCellVM.class, ^(CommonTableViewCellVM *cellVM){
                        cellVM.dataMSet([MainCellM mainMWithDic:dic]);
                    });
                }
            });
            
            vm.addSectionVMCreate(CommonTableViewSectionVM.class, ^(CommonTableViewSectionVM *sectionVM){
                sectionVM.dataMCreate(CommonM.class, ^(CommonM *model){
                    model.titleSet(@"运行时");
                });
            });
            
            vm.addSectionVMCreate(CommonTableViewSectionVM.class, ^(CommonTableViewSectionVM *sectionVM){
                sectionVM.dataMCreate(CommonM.class, ^(CommonM *model){
                    model.titleSet(@"GCD");
                });
            });
            
            vm.addSectionVMCreate(CommonTableViewSectionVM.class, ^(CommonTableViewSectionVM *sectionVM){
                sectionVM.dataMCreate(CommonM.class, ^(CommonM *model){
                    model.titleSet(@"算法");
                });
            });
        }];
    }
    
    return self;
}

@end
