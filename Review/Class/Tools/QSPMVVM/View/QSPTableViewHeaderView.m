//
//  QSPTableViewHeaderFooterView.m
//  ThreadingPrograming
//
//  Created by QSP on 2018/7/19.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "QSPTableViewHeaderView.h"

@interface QSPTableViewHeaderView ()

@property (weak, nonatomic) UILabel *titleL;
@property (weak, nonatomic) UILabel *detailL;

@end

@implementation QSPTableViewHeaderView

- (void)setSectionVMSet:(QSPTableViewSectionVM *)sectionVM {
    _sectionVM = sectionVM;
    
    if (sectionVM.headerTitle) {
        self.titleL.text = sectionVM.headerTitle;
    }
    if (sectionVM.headerDetail) {
        self.detailL.text = sectionVM.headerDetail;
    }
}
- (QSPTableViewHeaderView * (^)(QSPTableViewSectionVM *))sectionVMSet {
    return ^(QSPTableViewSectionVM *vm){
        self.sectionVMSet = vm;
        
        return self;
    };
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UILabel *titleL = [[UILabel alloc] init];
        titleL.numberOfLines = 0;
        titleL.textColor = self.textLabel.textColor;
        titleL.font = K_QSPTableViewHeaderFooterViewFont;
        [self.contentView addSubview:titleL];
        self.titleL = titleL;

        UILabel *detailL = [[UILabel alloc] init];
        detailL.numberOfLines = 0;
        detailL.textColor = self.detailTextLabel.textColor;
        detailL.font = K_QSPTableViewHeaderFooterViewFont;
        [self.contentView addSubview:detailL];
        self.detailL = detailL;
        
        CGFloat X = 15;
        CGFloat Y = 4;
        CGFloat W = K_QSPScreen_Width - 2*X;
        CGFloat H = 22;
        self.titleL.frame = CGRectMake(X, Y, W, H);
        
        Y = Y + H + 4;
        self.detailL.frame = CGRectMake(X, Y, W, H);
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
