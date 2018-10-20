//
//  CommonTableVieweHeaderView.m
//  ThreadingPrograming
//
//  Created by QSP on 2018/7/18.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "CommonTableViewHeaderView.h"

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
        self.titleL.frame = vm.headerTitleRect;
        self.detailL.frame = vm.headerDetailRect;
        
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
