//
//  QSPRowVM.m
//  ThreadingPrograming
//
//  Created by QSP on 2018/7/19.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "QSPTableViewCellVM.h"
#import "QSPTableViewCell.h"

@implementation QSPTableViewCellVM

- (instancetype)init {
    if (self = [super init]) {
        _cellClass = QSPTableViewCell.class;
        _style = UITableViewCellStyleDefault;
//        _cellHeight = @(44.0);
    }
    
    return self;
}

- (void)setCellClassSet:(Class)cellClass {
    _cellClass = cellClass;
}
- (QSPTableViewCellVM * (^)(Class))cellClassSet {
    return ^(Class class){
        self.cellClassSet = class;
        
        return self;
    };
}
- (void)setCellHeightSet:(CGFloat)cellHeight {
    _cellHeight = @(cellHeight);
}
- (QSPTableViewCellVM * (^)(CGFloat))cellHeightSet {
    return ^(CGFloat height){
        self.cellHeightSet = height;
        
        return self;
    };
}
- (void)setStyleSet:(UITableViewCellStyle)style {
    _style = style;
}
- (QSPTableViewCellVM * (^)(UITableViewCellStyle))styleSet {
    return ^(UITableViewCellStyle style){
        self.styleSet = style;
        
        return self;
    };
}
- (void)setAccessoryTypeSet:(UITableViewCellAccessoryType)accessoryType {
    _accessoryType = accessoryType;
}
- (QSPTableViewCellVM * (^)(UITableViewCellAccessoryType))accessoryTypeSet {
    return ^(UITableViewCellAccessoryType accessoryType){
        self.accessoryTypeSet = accessoryType;
        
        return self;
    };
}
- (void)setIconSet:(NSString *)value {
    _icon = value;
}
- (void)setTitleSet:(NSString *)value {
    _title = value;
}
- (void)setDetailSet:(NSString *)value {
    _detail = value;
}
- (QSPTableViewCellVM * (^)(NSString *))iconSet {
    return ^(NSString *value){
        self.iconSet = value;
        
        return self;
    };
}
- (QSPTableViewCellVM * (^)(NSString *))titleSet {
    return ^(NSString *value){
        self.titleSet = value;
        
        return self;
    };
}
- (QSPTableViewCellVM * (^)(NSString *))detailSet {
    return ^(NSString *value){
        self.detailSet = value;
        
        return self;
    };
}
//- (void)setSelectedBlockSet:(QSPSelectedBlock)block {
//    _selectedBlock = block;
//}
//- (QSPTableViewCellVM * (^)(QSPSelectedBlock))selectedBlockSet {
//    return ^(QSPSelectedBlock block){
//        self.selectedBlockSet = block;
//        
//        return self;
//    };
//}

@end
