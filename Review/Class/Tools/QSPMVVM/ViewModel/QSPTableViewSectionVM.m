//
//  CommonSectionVM.m
//  ThreadingPrograming
//
//  Created by QSP on 2018/7/19.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "QSPTableViewSectionVM.h"
#import "QSPTableViewHeaderView.h"
#import "QSPTableViewFooterView.h"

@interface QSPTableViewSectionVM ()

@property (strong, nonatomic) NSMutableArray<QSPTableViewCellVM *> *rowVMs;

@end

@implementation QSPTableViewSectionVM
@synthesize headerHeight = _headerHeight;
@synthesize footerHeight = _footerHeight;

- (instancetype)init {
    if (self = [super init]) {
        _headerClass = QSPTableViewHeaderView.class;
        _footerClass = QSPTableViewFooterView.class;
//        _headerHeight = @(0.0);
//        _footerHeight = @(0.0);
    }
    
    return self;
}

- (NSMutableArray *)rowVMs {
    if (_rowVMs == nil) {
        _rowVMs = [NSMutableArray arrayWithCapacity:1];
    }
    
    return _rowVMs;
}
- (NSInteger)rowCount {
    return self.rowVMs.count;
}
- (QSPTableViewSectionVM * (^)(QSPTableViewCellVM *))addRowVMSet {
    return ^(QSPTableViewCellVM *vm){
        [self.rowVMs addObject:vm];
        
        return self;
    };
}
- (QSPTableViewSectionVM * (^)(Class, QSPSetRowVMBlock))addRowVMCreate {
    return ^(Class class, QSPSetRowVMBlock block){
        id obj = class ? [[class alloc] init] : [[QSPTableViewCellVM alloc] init];
        if (block) {
            block(obj);
        }
        [self.rowVMs addObject:obj];
        
        return self;
    };
}
- (QSPTableViewSectionVM * (^)(QSPSetRowVMBlock))addQSPRowVMCreate {
    return ^(QSPSetRowVMBlock block){
        QSPTableViewCellVM *vm = [[QSPTableViewCellVM alloc] init];
        if (block) {
            block(vm);
        }
        [self.rowVMs addObject:vm];
        
        return self;
    };
}
- (QSPTableViewSectionVM * (^)(NSInteger, QSPTableViewCellVM *))insertRowVMSet {
    return ^(NSInteger index, QSPTableViewCellVM *vm){
        [self.rowVMs insertObject:vm atIndex:index];
        
        return self;
    };
}
- (QSPTableViewSectionVM * (^)(NSInteger, Class, QSPSetRowVMBlock))insertRowVMCreate {
    return ^(NSInteger index, Class class, QSPSetRowVMBlock block){
        id obj = class ? [[class alloc] init] : [[QSPTableViewCellVM alloc] init];
        if (block) {
            block(obj);
        }
        [self.rowVMs insertObject:obj atIndex:index];
        
        return self;
    };
}
- (QSPTableViewSectionVM * (^)(NSInteger, QSPSetRowVMBlock))insertQSPRowVMCreate {
    return ^(NSInteger index, QSPSetRowVMBlock block){
        QSPTableViewCellVM *vm = [[QSPTableViewCellVM alloc] init];
        if (block) {
            block(vm);
        }
        [self.rowVMs insertObject:vm atIndex:index];
        
        return self;
    };
}
- (void)setHeaderClassSet:(Class)class {
    _headerClass = class;
}
- (QSPTableViewSectionVM * (^)(Class))headerClassSet {
    return ^(Class class){
        self.headerClassSet = class;
        
        return self;
    };
}
- (void)setFooterClassSet:(Class)class {
    _footerClass = class;
}
- (QSPTableViewSectionVM * (^)(Class))footerClassSet {
    return ^(Class class){
        self.footerClassSet = class;
        
        return self;
    };
}
- (void)setHeaderHeightSet:(CGFloat)headerHeight {
    _headerHeight = @(headerHeight);
}
- (QSPTableViewSectionVM * (^)(CGFloat))headerHeightSet {
    return ^(CGFloat height){
        self.headerHeightSet = height;
        
        return self;
    };
}
- (void)setFooterHeightSet:(CGFloat)footerHeight {
    _footerHeight = @(footerHeight);
}
- (QSPTableViewSectionVM * (^)(CGFloat))footerHeightSet {
    return ^(CGFloat height){
        self.footerHeightSet = height;
        
        return self;
    };
}
- (void)setHeaderTitleSet:(NSString *)value {
    _headerTitle = value;
    _headerHeight = self.headerDetail ? @(52.0) : (self.headerTitle ? @(30.0) : @(0.0));
}
- (void)setHeaderDetailSet:(NSString *)value {
    _headerDetail = value;
    _headerHeight = self.headerDetail ? @(52.0): (self.headerTitle ? @(30.0) : @(0.0));
}
- (void)setFooterTitleSet:(NSString *)value {
    _footerTitle = value;
    _footerHeight = self.footerDetail ? @(52.0): (self.footerTitle ? @(30.0) : @(0.0));
}
- (void)setFooterDetailSet:(NSString *)value {
    _footerDetail = value;
    _footerHeight = self.footerDetail ? @(52.0): (self.footerTitle ? @(30.0) : @(0.0));
}
- (QSPTableViewSectionVM * (^)(NSString *))headerTitleSet {
    return ^(NSString *value){
        self.headerTitleSet = value;
        
        return self;
    };
}
- (QSPTableViewSectionVM * (^)(NSString *))footerTitleSet {
    return ^(NSString *value){
        self.footerTitleSet = value;
        
        return self;
    };
}
- (QSPTableViewSectionVM * (^)(NSString *))headerDetailSet {
    return ^(NSString *value){
        self.headerDetailSet = value;
        
        return self;
    };
}
- (QSPTableViewSectionVM * (^)(NSString *))footerDetailSet {
    return ^(NSString *value){
        self.footerDetailSet = value;
        
        return self;
    };
}

- (QSPTableViewCellVM *)rowModelWithRow:(NSInteger)row {
    return [self.rowVMs objectAtIndex:row];
}
- (NSInteger)rowOfCellVM:(QSPTableViewCellVM *)vm {
    return [self.rowVMs indexOfObject:vm];
}

@end
