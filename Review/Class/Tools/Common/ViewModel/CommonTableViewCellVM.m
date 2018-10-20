//
//  CommonTableViewCellVM.m
//  ThreadManagement
//
//  Created by QSP on 2018/7/23.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "CommonTableViewCellVM.h"
#import "CommonTableViewCell.h"

@implementation CommonTableViewCellVM

- (void)setTitleRect:(CGRect)titleRect {
    _titleRect = titleRect;
}
- (void)setDetailRect:(CGRect)detailRect {
    _detailRect = detailRect;
}
- (QSPViewVM *(^)(id))dataMSet {
    return ^(CommonM *data){
        super.dataMSet(data);
        
        CGFloat X = 15.0;
        CGFloat Y = 8.0;
        CGFloat W = K_QSPScreen_Width - X - 35;
        CGFloat H = [data.title boundingRectWithSize:CGSizeMake(W, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: K_QSPTableViewCellTitleFont} context:nil].size.height;
        self.titleRect = CGRectMake(X, Y, W, H);
        
        Y = Y + H + 4;
        H = [data.detail boundingRectWithSize:CGSizeMake(W, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: K_QSPTableViewCellDetailFont} context:nil].size.height;
        self.detailRect = CGRectMake(X, Y, W, H);
        
        self.cellHeightSet(Y + H + 8);
        
        return self;
    };
}

- (instancetype)init {
    if (self = [super init]) {
        self.cellClassSet(CommonTableViewCell.class).styleSet(UITableViewCellStyleDefault).accessoryTypeSet(UITableViewCellAccessoryDisclosureIndicator);
    }
    
    return self;
}

@end
