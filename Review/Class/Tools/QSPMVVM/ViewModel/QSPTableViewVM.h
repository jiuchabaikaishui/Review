//
//  QSPTableViewVM.h
//  ThreadingPrograming
//
//  Created by QSP on 2018/7/19.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "QSPScrollViewVM.h"
#import "QSPTableViewSectionVM.h"
#import "QSPTableViewCell.h"
#import "QSPTableViewHeaderView.h"
#import "QSPTableViewFooterView.h"

@interface QSPTableViewAndIndexPath: NSObject

@property (weak, nonatomic, readonly) UITableView *tableView;
@property (strong, nonatomic, readonly) NSIndexPath *indexPath;

+ (instancetype)tableView:(UITableView *)tableView andIndex:(NSIndexPath *)indexPath;
- (instancetype)initWithtableView:(UITableView *)tableView andIndex:(NSIndexPath *)indexPath;

@end

@class QSPTableViewVM;

typedef void (^QSPCreateObjectBlock)(id);

@interface QSPTableViewVM : QSPScrollViewVM <UITableViewDataSource, UITableViewDelegate>

@property (assign, nonatomic, readonly) NSInteger section;
@property (strong, nonatomic, readonly) UIView *tableHeaderView;
@property (strong, nonatomic, readonly) UIView *tableFooterView;

@property (assign, nonatomic, readonly) Class sectionHeaderClass;
@property (assign, nonatomic, readonly) Class sectionFooterClass;
@property (strong, nonatomic, readonly) id sectionHeaderHeight;
@property (strong, nonatomic, readonly) id sectionFooterHeight;
@property (strong, nonatomic, readonly) UIColor *sectionHeaderColor;
@property (strong, nonatomic, readonly) UIColor *sectionFooterColor;

@property (assign, nonatomic, readonly) Class cellClass;
@property (strong, nonatomic, readonly) id cellHeight;

+ (QSPTableViewVM *)create:(void (^)(QSPTableViewVM *vm))block;
- (QSPTableViewVM * (^)(QSPTableViewSectionVM *))addSectionVM;
- (QSPTableViewVM * (^)(Class, QSPCreateObjectBlock))addSectionVMCreate;
- (QSPTableViewVM * (^)(QSPCreateObjectBlock))addQSPSectionVMCreate;
- (QSPTableViewVM * (^)(UIView *))tableHeaderViewSet;
- (QSPTableViewVM * (^)(UIView *))tableFooterViewSet;
- (QSPTableViewVM * (^)(Class, QSPCreateObjectBlock))tableHeaderViewCreate;
- (QSPTableViewVM * (^)(Class, QSPCreateObjectBlock))tableFooterViewCreate;

- (QSPTableViewVM * (^)(Class))sectionHeaderClassSet;
- (QSPTableViewVM * (^)(Class))sectionFooterClassSet;
- (QSPTableViewVM * (^)(CGFloat))sectionHeaderHeightSet;
- (QSPTableViewVM * (^)(CGFloat))sectionFooterHeightSet;
- (QSPTableViewVM * (^)(UIColor *))sectionHeaderColorSet;
- (QSPTableViewVM * (^)(UIColor *))sectionFooterColorSet;

- (QSPTableViewVM * (^)(Class))cellClassSet;
- (QSPTableViewVM * (^)(CGFloat))cellHeightSet;

- (id)sectionVMWithSection:(NSInteger)section;
- (id)rowVMWithIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)sectionOfSctionVM:(QSPTableViewSectionVM *)vm;

@property (strong, nonatomic, readonly) RACSignal *didSelectRowSignal;

@end
