//
//  QSPTableViewVM.m
//  ThreadingPrograming
//
//  Created by QSP on 2018/7/19.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "QSPTableViewVM.h"

@implementation QSPTableViewAndIndexPath

+ (instancetype)tableView:(UITableView *)tableView andIndex:(NSIndexPath *)indexPath {
    return [[self alloc] initWithtableView:tableView andIndex:indexPath];
}
- (instancetype)initWithtableView:(UITableView *)tableView andIndex:(NSIndexPath *)indexPath {
    if (self = [super init]) {
        _tableView = tableView;
        _indexPath = indexPath;
    }
    
    return self;
}

@end

@interface QSPTableViewVM ()

@property (weak, nonatomic) id<RACSubscriber> didSelectRowSubscriber;

@end

@interface QSPTableViewVM ()

@property (strong, nonatomic) NSMutableArray<QSPTableViewSectionVM *> *sectionVMs;

@end

@implementation QSPTableViewVM

+ (QSPTableViewVM *)create:(void (^)(QSPTableViewVM *vm))block {
    if (block) {
        QSPTableViewVM *vm = [[QSPTableViewVM alloc] init];
        block(vm);
        
        return vm;
    }
    
    return nil;
}

- (instancetype)init {
    if (self = [super init]) {
        self.tableFooterViewCreate(UIView.class, nil);
        
        _didSelectRowSignal = [RACSignal defer:^RACSignal * _Nonnull{
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                self.didSelectRowSubscriber = subscriber;
                return [RACDisposable disposableWithBlock:^{
                    [subscriber sendCompleted];
                }];
            }];
        }];
    }
    
    return self;
}

- (NSMutableArray *)sectionVMs {
    if (_sectionVMs == nil) {
        _sectionVMs = [NSMutableArray arrayWithCapacity:1];
    }
    
    return _sectionVMs;
}
- (NSInteger)section {
    return self.sectionVMs.count;
}

- (QSPTableViewVM * (^)(QSPTableViewSectionVM *))addSectionVM {
    return ^(QSPTableViewSectionVM *sectionVM){
        [self.sectionVMs addObject:sectionVM];
        
        return self;
    };
}
- (QSPTableViewVM * (^)(Class, QSPCreateObjectBlock))addSectionVMCreate {
    return ^(Class class, QSPCreateObjectBlock block){
        QSPTableViewSectionVM *sectionVM = class ? [[class alloc] init] : [[QSPTableViewSectionVM alloc] init];
        if (block) {
            block(sectionVM);
        }
        [self.sectionVMs addObject:sectionVM];
        
        return self;
    };
}
- (QSPTableViewVM * (^)(QSPCreateObjectBlock))addQSPSectionVMCreate {
    return ^(QSPCreateObjectBlock block){
        QSPTableViewSectionVM *sectionVM = [[QSPTableViewSectionVM alloc] init];
        if (block) {
            block(sectionVM);
        }
        [self.sectionVMs addObject:sectionVM];
        
        return self;
    };
}
- (void)setTableHeaderViewSet:(UIView *)tableHeaderView {
    _tableHeaderView = tableHeaderView;
}
- (QSPTableViewVM * (^)(UIView *))tableHeaderViewSet {
    return ^(UIView *view){
        self.tableHeaderViewSet = view;
        
        return self;
    };
}
- (QSPTableViewVM * (^)(Class, QSPCreateObjectBlock))tableHeaderViewCreate {
    return ^(Class class, QSPCreateObjectBlock block){
        UIView *view = [[class alloc] init];
        if (block) {
            block(view);
        }
        self.tableHeaderViewSet = view;
        
        return self;
    };
}
- (void)setTableFooterViewSet:(UIView *)tableFooterView {
    _tableFooterView = tableFooterView;
}
- (QSPTableViewVM * (^)(UIView *))tableFooterViewSet {
    return ^(UIView *view){
        self.tableFooterViewSet = view;
        
        return self;
    };
}
- (QSPTableViewVM * (^)(Class, QSPCreateObjectBlock))tableFooterViewCreate {
    return ^(Class class, QSPCreateObjectBlock block){
        UIView *view = [[class alloc] init];
        if (block) {
            block(view);
        }
        self.tableFooterViewSet = view;
        
        return self;
    };
}

- (void)setSectionHeaderClassSet:(Class)sectionHeaderClass {
    _sectionHeaderClass = sectionHeaderClass;
}
- (QSPTableViewVM * (^)(Class))sectionHeaderClassSet {
    return ^(Class class) {
        self.sectionHeaderClassSet = class;
        
        return self;
    };
}
- (void)setSectionFooterClassSet:(Class)sectionFooterClass {
    _sectionFooterClass = sectionFooterClass;
}
- (QSPTableViewVM * (^)(Class))sectionFooterClassSet {
    return ^(Class class) {
        self.sectionFooterClassSet = class;
        
        return self;
    };
}
- (void)setSectionHeaderHeightSet:(CGFloat)sectionHeaderHeight {
    _sectionHeaderHeight = @(sectionHeaderHeight);
}
- (QSPTableViewVM * (^)(CGFloat))sectionHeaderHeightSet {
    return ^(CGFloat height) {
        self.sectionHeaderHeightSet = height;
        
        
        return self;
    };
}
- (void)setSectionFooterHeightSet:(CGFloat)sectionFooterHeight {
    _sectionFooterHeight = @(sectionFooterHeight);
}
- (QSPTableViewVM * (^)(CGFloat))sectionFooterHeightSet {
    return ^(CGFloat height) {
        self.sectionFooterHeightSet = height;
        
        return self;
    };
}
- (void)setSectionHeaderColorSet:(UIColor *)sectionHeaderColor {
    _sectionHeaderColor = sectionHeaderColor;
}
- (QSPTableViewVM * (^)(UIColor *))sectionHeaderColorSet {
    return ^(UIColor *color) {
        self.sectionHeaderColorSet = color;
        
        return self;
    };
}
- (void)setSectionFooterColorSet:(UIColor *)sectionFooterColor {
    _sectionFooterColor = sectionFooterColor;
}
- (QSPTableViewVM * (^)(UIColor *))sectionFooterColorSet {
    return ^(UIColor *color) {
        self.sectionFooterColorSet = color;
        
        return self;
    };
}

- (void)setCellClassSet:(Class)cellClass {
    _cellClass = cellClass;
}
- (QSPTableViewVM * (^)(Class))cellClassSet {
    return ^(Class class) {
        self.cellClassSet = class;
        
        return self;
    };
}
- (void)setCellHeightSet:(CGFloat)cellHeight {
    _cellHeight = @(cellHeight);
}
- (QSPTableViewVM * (^)(CGFloat))cellHeightSet {
    return ^(CGFloat height) {
        self.cellHeightSet = height;
        
        return self;
    };
}

- (id)sectionVMWithSection:(NSInteger)section {
    return [self.sectionVMs objectAtIndex:section];
}
- (id)rowVMWithIndexPath:(NSIndexPath *)indexPath {
    return [[self.sectionVMs objectAtIndex:indexPath.section] rowModelWithRow:indexPath.row];
}
- (NSInteger)sectionOfSctionVM:(QSPTableViewSectionVM *)vm {
    return [self.sectionVMs indexOfObject:vm];
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionVMs.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    QSPTableViewSectionVM *sectionVM = [self sectionVMWithSection:section];
    return sectionVM.rowCount;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    QSPTableViewCellVM *rowMV = [self rowVMWithIndexPath:indexPath];
    id height = rowMV.cellHeight ? rowMV.cellHeight : self.cellHeight;
    
    return height ? [height floatValue] : 44.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QSPTableViewCellVM *rowMV = [self rowVMWithIndexPath:indexPath];
    Class cellClass = self.cellClass ? self.cellClass : (rowMV.cellClass ? rowMV.cellClass : QSPTableViewCell.class);
    NSString *identifier = NSStringFromClass(cellClass);
    QSPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[cellClass alloc] initWithStyle:rowMV.style reuseIdentifier:identifier];
    }
    
    cell.cellVMSet(rowMV);
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.didSelectRowSubscriber sendNext:[QSPTableViewAndIndexPath tableView:tableView andIndex:indexPath]];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    QSPTableViewSectionVM *sectionVM = [self sectionVMWithSection:section];
    id height = sectionVM.headerHeight ? sectionVM.headerHeight : self.sectionHeaderHeight;

    return height ? [height floatValue] : 0.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    QSPTableViewSectionVM *sectionVM = [self sectionVMWithSection:section];
    Class headerClass = sectionVM.headerClass ? sectionVM.headerClass : QSPTableViewHeaderView.class;
    if (headerClass) {
        NSString *identifier = NSStringFromClass(headerClass);
        QSPTableViewHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
        if (header == nil) {
            header = [[headerClass alloc] initWithReuseIdentifier:identifier];
            if (self.sectionHeaderColor) {
                header.contentView.backgroundColor = self.sectionHeaderColor;
            }
        }
        
        header.sectionVMSet(sectionVM);
        
        return header;
    }
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    QSPTableViewSectionVM *sectionVM = [self sectionVMWithSection:section];
    id height = sectionVM.footerHeight ? sectionVM.footerHeight : self.sectionFooterHeight;

    return height ? [height floatValue] : 0.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    QSPTableViewSectionVM *sectionVM = [self sectionVMWithSection:section];
    if (sectionVM.footerClass) {
        NSString *identifier = NSStringFromClass(sectionVM.footerClass);
        QSPTableViewFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
        if (footer == nil) {
            footer = [[sectionVM.footerClass alloc] initWithReuseIdentifier:identifier];
            if (self.sectionFooterColor) {
                footer.contentView.backgroundColor = self.sectionFooterColor;
            }
        }

        footer.sectionVMSet(sectionVM);

        return footer;
    }

    return nil;
}

@end
