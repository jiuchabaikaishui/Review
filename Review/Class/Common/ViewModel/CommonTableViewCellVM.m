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

- (void)setTitleHeight:(CGFloat)titleHeight {
    _titleHeight = titleHeight;
}
- (void)setDetailHeight:(CGFloat)detailHeight {
    _detailHeight = detailHeight;
}
- (void)setTitleLandscapeHeight:(CGFloat)titleLandscapeHeight {
    _titleLandscapeHeight = titleLandscapeHeight;
}
- (void)setDetailLandscapeHeight:(CGFloat)detailLandscapeHeight {
    _detailLandscapeHeight = detailLandscapeHeight;
}
- (void)setCellLandscapeHeight:(id)cellLandscapeHeight {
    _cellLandscapeHeight = cellLandscapeHeight;
}
- (QSPViewVM *(^)(id))dataMSet {
    return ^(CommonM *data){
        super.dataMSet(data);
        
        CGFloat screenW = 0.0;
        if (K_QSPScreen_Width < K_QSPScreen_Height) {
            screenW = K_QSPScreen_Width;
        } else {
            screenW = K_QSPScreen_Height;
        }
        CGFloat X = 15.0;
        CGFloat Y = 8.0;
        CGFloat W = screenW - X - 36;
        CGFloat H = ceilf([data.title boundingRectWithSize:CGSizeMake(W, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: K_QSPTableViewCellTitleFont} context:nil].size.height);
        self.titleHeight = H;
        
        Y = Y + H + 4;
        H = ceilf([data.detail boundingRectWithSize:CGSizeMake(W, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: K_QSPTableViewCellDetailFont} context:nil].size.height);
        self.detailHeight = H;
        
        self.cellHeightSet(Y + H + 8);
        
        
        if (K_QSPScreen_Width > K_QSPScreen_Height) {
            screenW = K_QSPScreen_Width;
        } else {
            screenW = K_QSPScreen_Height;
        }
        X = 15.0;
        Y = 8.0;
        W = screenW - X - 36 - (K_QSPISIphoneX ? 88.0 : 0.0);
        H = ceilf([data.title boundingRectWithSize:CGSizeMake(W, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: K_QSPTableViewCellTitleFont} context:nil].size.height);
        self.titleLandscapeHeight = H;
        
        Y = Y + H + 4;
        H = ceilf([data.detail boundingRectWithSize:CGSizeMake(W, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: K_QSPTableViewCellDetailFont} context:nil].size.height);
        self.detailLandscapeHeight = H;
        
        self.cellLandscapeHeight = @(Y + H + 8);
        
        return self;
    };
}
- (void)bindData {
    CommonM *data = self.dataM;
    RACSignal *detailS = RACObserve(data, detail);
    [detailS subscribeNext:^(id  _Nullable x) {
        NSLog(@"++++++++++%@, %@", data, x);
    }];
}

- (instancetype)init {
    if (self = [super init]) { self.cellClassSet(CommonTableViewCell.class).styleSet(UITableViewCellStyleDefault).accessoryTypeSet(UITableViewCellAccessoryNone);
    }
    
    return self;
}
- (QSPTableViewCellVM *(^)(UITableViewCellAccessoryType))accessoryTypeSet {
    return ^QSPTableViewCellVM *(UITableViewCellAccessoryType type) {
        super.accessoryTypeSet(UITableViewCellAccessoryNone);
        return self;
    };
}

@end
