//
//  CommonTableViewVM.m
//  Review
//
//  Created by 綦帅鹏 on 2019/7/1.
//  Copyright © 2019 QSP. All rights reserved.
//

#import "CommonTableViewVM.h"
#import "CommonTableViewCellVM.h"
#import "CommonTableViewSectionVM.h"

@implementation CommonTableViewVM

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommonTableViewCellVM *rowMV = [self rowVMWithIndexPath:indexPath];
    if (K_QSPScreen_Width > K_QSPScreen_Height) {
        id height = rowMV.cellLandscapeHeight ? rowMV.cellLandscapeHeight : self.cellHeight;
        
        return height ? [height floatValue] : 44.0;
    } else {
        id height = rowMV.cellHeight ? rowMV.cellHeight : self.cellHeight;
        
        return height ? [height floatValue] : 44.0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CommonTableViewSectionVM *sectionVM = [self sectionVMWithSection:section];
    if (K_QSPScreen_Width > K_QSPScreen_Height) {
        id height = sectionVM.headerLandscapeHeight ? sectionVM.headerLandscapeHeight : self.sectionHeaderHeight;
        
        return height ? [height floatValue] : 0.0;
    } else {
        id height = sectionVM.headerHeight ? sectionVM.headerHeight : self.sectionHeaderHeight;
        
        return height ? [height floatValue] : 0.0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    QSPTableViewSectionVM *sectionVM = [self sectionVMWithSection:section];
    id height = sectionVM.footerHeight ? sectionVM.footerHeight : self.sectionFooterHeight;
    
    return height ? [height floatValue] : 0.0;
}

@end
