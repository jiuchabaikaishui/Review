//
//  CommonTableVieweHeaderView.m
//  ThreadingPrograming
//
//  Created by QSP on 2018/7/18.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "CommonTableViewHeaderView.h"
#import "Masonry.h"

@interface CommonTableViewHeaderView()

@property (weak, nonatomic) UILabel *titleL;
@property (weak, nonatomic) UILabel *detailL;

@end

@implementation CommonTableViewHeaderView
- (QSPTableViewHeaderView * (^)(CommonTableViewSectionVM *))sectionVMSet {
    return ^(CommonTableViewSectionVM *vm){
        super.sectionVMSet(vm);
        
        CommonM *commonM = vm.dataM;
        self.titleL.text = commonM.title;
        self.detailL.text = commonM.detail;
        
        return self;
    };
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CommonTableViewSectionVM *vm = (CommonTableViewSectionVM *)self.sectionVM;
    [self.titleL mas_updateConstraints:^(MASConstraintMaker *make) {
        if (K_QSPScreen_Width > K_QSPScreen_Height) {
            make.height.equalTo(@(vm.headerTitleLandscapeHeight));
        } else {
            make.height.equalTo(@(vm.headerTitleHeight));
        }
    }];
    [self.detailL mas_updateConstraints:^(MASConstraintMaker *make) {
        if (K_QSPScreen_Width > K_QSPScreen_Height) {
            make.height.equalTo(@(vm.headerDetailLandscapeHeight));
        } else {
            make.height.equalTo(@(vm.headerDetailHeight));
        }
    }];
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UILabel *titleL = [[UILabel alloc] init];
        titleL.numberOfLines = 0;
        titleL.textColor = self.textLabel.textColor;
        titleL.font = K_QSPTableViewHeaderFooterViewFont;
        [self.contentView addSubview:titleL];
        self.titleL = titleL;
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15.0);
            make.right.equalTo(self.contentView).offset(-15.0);
            make.top.equalTo(self.contentView).offset(8.0);
        }];
        
        UILabel *detailL = [[UILabel alloc] init];
        detailL.numberOfLines = 0;
        detailL.textColor = self.detailTextLabel.textColor;
        detailL.font = K_QSPTableViewHeaderFooterViewFont;
        [self.contentView addSubview:detailL];
        self.detailL = detailL;
        [detailL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15.0);
            make.right.equalTo(self.contentView).offset(-15.0);
            make.bottom.equalTo(self.contentView).offset(-8.0);
        }];
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
