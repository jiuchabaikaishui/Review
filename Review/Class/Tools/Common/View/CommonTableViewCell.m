//
//  CommonTableViewCell.m
//  ThreadManagement
//
//  Created by QSP on 2018/7/23.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "CommonTableViewCell.h"

@interface CommonTableViewCell ()

@property (weak, nonatomic) UILabel *titleL;
@property (weak, nonatomic) UILabel *detailL;

@end

@implementation CommonTableViewCell

- (CommonTableViewCell *(^)(CommonTableViewCellVM *))cellVMSet {
    return ^(CommonTableViewCellVM *vm){
        super.cellVMSet(vm);
        
        CommonM *commonM = vm.dataM;
        self.titleL.text = commonM.title;
        self.detailL.text = commonM.detail;
        self.titleL.frame = vm.titleRect;
        self.detailL.frame = vm.detailRect;
        
        return self;
    };
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *titleL = [[UILabel alloc] init];
        titleL.numberOfLines = 0;
        titleL.textColor = self.textLabel.textColor;
        titleL.font = K_QSPTableViewCellTitleFont;
        [self.contentView addSubview:titleL];
        self.titleL = titleL;
        
        UILabel *detailL = [[UILabel alloc] init];
        detailL.numberOfLines = 0;
        detailL.textColor = self.detailTextLabel.textColor;
        detailL.font = K_QSPTableViewCellDetailFont;
        [self.contentView addSubview:detailL];
        self.detailL = detailL;
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
