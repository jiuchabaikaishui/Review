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
        self.tableViewVM = [CommonTableViewVM create:^(QSPTableViewVM *vm) {
            NSArray *arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ReviewList" ofType:@"plist"]];
            for (NSDictionary *section in arr) {
                vm.addSectionVMCreate(CommonTableViewSectionVM.class, ^(CommonTableViewSectionVM *sectionVM){
                    sectionVM.dataMCreate(CommonM.class, ^(CommonM *model){
                        model.titleSet(section[@"title"]).detailSet(section[@"detail"]);
                    });
                    for (NSDictionary *row in section[@"rows"]) {
                        sectionVM.addRowVMCreate(CommonTableViewCellVM.class, ^(CommonTableViewCellVM *cellVM){
                            cellVM.dataMSet([MainCellM mainMWithDic:row]);
                        });
                    }
                });
            }
        }];
    }
    
    return self;
}

@end
