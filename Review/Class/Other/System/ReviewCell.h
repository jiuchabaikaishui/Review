//
//  ReviewCell.h
//  Review
//
//  Created by apple on 17/5/26.
//  Copyright © 2017年 QSP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReviewModel.h"

@interface ReviewCell : UITableViewCell
@property (strong,nonatomic) ReviewModel *model;

+ (instancetype)reviewCellWithTableView:(UITableView *)tableView andReviewModel:(ReviewModel *)model;

@end
