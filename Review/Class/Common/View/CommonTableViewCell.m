//
//  CommonTableViewCell.m
//  ThreadManagement
//
//  Created by QSP on 2018/7/23.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "CommonTableViewCell.h"
#import "Masonry.h"

@interface CommonTableViewCell ()

@property (weak, nonatomic) UILabel *titleL;
@property (weak, nonatomic) UILabel *detailL;
@property (weak, nonatomic) UILabel *accessoryV;

@end

@implementation CommonTableViewCell

- (CommonTableViewCell *(^)(CommonTableViewCellVM *))cellVMSet {
    return ^(CommonTableViewCellVM *vm){
        super.cellVMSet(vm);
        
        CommonM *commonM = vm.dataM;
        self.titleL.text = commonM.title;
        self.detailL.text = commonM.detail;
        
        return self;
    };
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CommonTableViewCellVM *vm = (CommonTableViewCellVM *)self.cellVM;
    [self.titleL mas_updateConstraints:^(MASConstraintMaker *make) {
        if (K_QSPScreen_Width > K_QSPScreen_Height) {
            make.height.equalTo(@(vm.titleLandscapeHeight));
        } else {
            make.height.equalTo(@(vm.titleHeight));
        }
    }];
    [self.detailL mas_updateConstraints:^(MASConstraintMaker *make) {
        if (K_QSPScreen_Width > K_QSPScreen_Height) {
            make.height.equalTo(@(vm.detailLandscapeHeight));
        } else {
            make.height.equalTo(@(vm.detailHeight));
        }
    }];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *accessoryV = [[UILabel alloc] init];
        accessoryV.numberOfLines = 0;
        accessoryV.textColor = [UIColor lightGrayColor];
        accessoryV.font = K_QSPTableViewCellTitleFont;
        accessoryV.textAlignment = NSTextAlignmentCenter;
        accessoryV.text = @"⌃";
        [self.contentView addSubview:accessoryV];
        accessoryV.transform = CGAffineTransformRotate(accessoryV.transform, M_PI_2);
        self.accessoryV = accessoryV;
        [accessoryV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-8.0);
            make.width.height.equalTo(@(20));
        }];
        
        UILabel *titleL = [[UILabel alloc] init];
        titleL.numberOfLines = 0;
        titleL.textColor = self.textLabel.textColor;
        titleL.font = K_QSPTableViewCellTitleFont;
        [self.contentView addSubview:titleL];
        self.titleL = titleL;
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15.0);
            make.top.equalTo(self.contentView).offset(8.0);
            make.right.equalTo(self.accessoryV.mas_left).offset(-8.0);
        }];
        
        UILabel *detailL = [[UILabel alloc] init];
        detailL.numberOfLines = 0;
        detailL.textColor = self.detailTextLabel.textColor;
        detailL.font = K_QSPTableViewCellDetailFont;
        [self.contentView addSubview:detailL];
        self.detailL = detailL;
        [detailL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15.0);
            make.bottom.equalTo(self.contentView).offset(-8.0);
            make.right.equalTo(self.accessoryV.mas_left).offset(-8.0);
        }];
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
