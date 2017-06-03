//
//  ReviewCell.m
//  Review
//
//  Created by apple on 17/5/26.
//  Copyright © 2017年 QSP. All rights reserved.
//

#import "ReviewCell.h"

#define Title_Color                 [UIColor blackColor]
#define Describe_Color              [UIColor darkGrayColor]

@implementation ReviewCell

#pragma mark - 属性方法
- (void)setModel:(ReviewModel *)model
{
    if (model) {
        _model = model;
        self.textLabel.text = model.title;
        self.detailTextLabel.text = model.describe;
        self.textLabel.frame = model.titleRect;
        self.detailTextLabel.frame = model.describeRect;
    }
}

+ (instancetype)reviewCellWithTableView:(UITableView *)tableView andReviewModel:(ReviewModel *)model
{
    static NSString *identifier = @"ReviewCellIdentifier";
    ReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.model = model;
    }
    
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier]) {
        self.textLabel.numberOfLines = 0;
        self.textLabel.font = Title_Font;
        self.textLabel.textColor = Title_Color;
        self.detailTextLabel.numberOfLines = 0;
        self.detailTextLabel.font = Describe_Font;
        self.detailTextLabel.textColor = Describe_Color;
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
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
