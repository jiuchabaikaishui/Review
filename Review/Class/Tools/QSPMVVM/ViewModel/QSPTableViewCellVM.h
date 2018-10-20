//
//  QSPRowVM.h
//  ThreadingPrograming
//
//  Created by QSP on 2018/7/19.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "QSPViewVM.h"
#import <UIKit/UIKit.h>

#define K_QSPScreen_Width                           [UIScreen mainScreen].bounds.size.width
#define K_QSPTableViewHeaderFooterViewFont          [UIFont systemFontOfSize:13]
#define K_QSPTableViewCellTitleFont                 [UIFont systemFontOfSize:17]
#define K_QSPTableViewCellDetailFont                [UIFont systemFontOfSize:12]
typedef void (^QSPSelectedBlock)(id obj, NSIndexPath *indexPath);

@interface QSPTableViewCellVM : QSPViewVM

@property (assign, nonatomic, readonly) Class cellClass;
@property (strong, nonatomic, readonly) id cellHeight;
@property (assign, nonatomic, readonly) UITableViewCellStyle style;
@property (assign, nonatomic, readonly) UITableViewCellAccessoryType accessoryType;
@property (copy, nonatomic, readonly) NSString *icon;
@property (copy, nonatomic, readonly) NSString *title;
@property (copy, nonatomic, readonly) NSString *detail;
//@property (copy, nonatomic, readonly) QSPSelectedBlock selectedBlock;

- (QSPTableViewCellVM * (^)(Class))cellClassSet;
- (QSPTableViewCellVM * (^)(CGFloat))cellHeightSet;
- (QSPTableViewCellVM * (^)(UITableViewCellStyle))styleSet;
- (QSPTableViewCellVM * (^)(UITableViewCellAccessoryType))accessoryTypeSet;
- (QSPTableViewCellVM * (^)(NSString *))iconSet;
- (QSPTableViewCellVM * (^)(NSString *))titleSet;
- (QSPTableViewCellVM * (^)(NSString *))detailSet;
//- (QSPTableViewCellVM * (^)(QSPSelectedBlock))selectedBlockSet;

@end
