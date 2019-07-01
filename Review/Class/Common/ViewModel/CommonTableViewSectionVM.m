//
//  CommonTableViewSectionVM.m
//  ThreadManagement
//
//  Created by QSP on 2018/7/23.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "CommonTableViewSectionVM.h"
#import "CommonTableViewHeaderView.h"

@implementation CommonTableViewSectionVM

- (void)setHeaderTitleHeight:(CGFloat)headerTitleHeight {
    _headerTitleHeight = headerTitleHeight;
}
- (void)setHeaderDetailHeight:(CGFloat)headerDetailHeight {
    _headerDetailHeight = headerDetailHeight;
}
- (void)setHeaderTitleLandscapeHeight:(CGFloat)headerTitleLandscapeHeight {
    _headerTitleLandscapeHeight = headerTitleLandscapeHeight;
}
- (void)setHeaderDetailLandscapeHeight:(CGFloat)headerDetailLandscapeHeight {
    _headerDetailLandscapeHeight = headerDetailLandscapeHeight;
}
- (void)setHeaderLandscapeHeight:(id)headerLandscapeHeight {
    _headerLandscapeHeight = headerLandscapeHeight;
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
        CGFloat X = 15;
        CGFloat Y = 4;
        CGFloat W = screenW - 2*X;
        CGFloat H = 0;
        
        if (data.title && (![data.title isEqualToString:@""])) {
            H = [data.title boundingRectWithSize:CGSizeMake(W, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: K_QSPTableViewHeaderFooterViewFont} context:nil].size.height;
            self.headerTitleHeight = H;
        }
        Y = Y + H + 8;
        if (data.detail && (![data.detail isEqualToString:@""])) {
            H = [data.detail boundingRectWithSize:CGSizeMake(W, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: K_QSPTableViewHeaderFooterViewFont} context:nil].size.height;
            self.headerDetailHeight = H;
            Y = Y + H + 4;
        }
        
        self.headerHeightSet(Y);
        
        
        if (K_QSPScreen_Width > K_QSPScreen_Height) {
            screenW = K_QSPScreen_Width;
        } else {
            screenW = K_QSPScreen_Height;
        }
        X = 15;
        Y = 4;
        W = screenW - 2*X - (K_QSPISIphoneX ? 88.0 : 0.0);
        H = 0;
        
        if (data.title && (![data.title isEqualToString:@""])) {
            H = [data.title boundingRectWithSize:CGSizeMake(W, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: K_QSPTableViewHeaderFooterViewFont} context:nil].size.height;
            self.headerTitleLandscapeHeight = H;
        }
        Y = Y + H + 8;
        if (data.detail && (![data.detail isEqualToString:@""])) {
            H = [data.detail boundingRectWithSize:CGSizeMake(W, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: K_QSPTableViewHeaderFooterViewFont} context:nil].size.height;
            self.headerDetailLandscapeHeight = H;
            Y = Y + H + 4;
        }
        
        self.headerLandscapeHeight = @(Y);
        
        return self;
    };
}

- (instancetype)init {
    if (self = [super init]) {
        self.headerClassSet(CommonTableViewHeaderView.class);
    }
    
    return self;
}

@end
