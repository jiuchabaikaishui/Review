//
//  QSPTableViewCell.m
//  ThreadingPrograming
//
//  Created by QSP on 2018/7/19.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "QSPTableViewCell.h"

@implementation QSPTableViewCell

- (void)setCellVMSet:(QSPTableViewCellVM *)cellVM {
    _cellVM = cellVM;
    if (cellVM.icon) {
        self.imageView.image = [UIImage imageNamed:cellVM.icon];
    }
    if (cellVM.title) {
        self.textLabel.text = cellVM.title;
    }
    if (cellVM.detail) {
        self.detailTextLabel.text = cellVM.detail;
    }
    
    self.accessoryType = cellVM.accessoryType;
}
- (QSPTableViewCell * (^)(QSPTableViewCellVM *))cellVMSet {
    return ^(QSPTableViewCellVM *vm){
        self.cellVMSet = vm;
        
        return self;
    };
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
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
