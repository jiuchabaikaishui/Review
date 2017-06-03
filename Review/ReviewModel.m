//
//  ReviewModel.m
//  Review
//
//  Created by apple on 17/5/26.
//  Copyright © 2017年 QSP. All rights reserved.
//

#import "ReviewModel.h"

#define Screen_Width            [UIScreen mainScreen].bounds.size.width

@implementation ReviewModel

#pragma mark - 属性方法

+ (instancetype)reviewModelWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}
- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        if (dic) {
            self.title = dic[@"title"];
            self.describe = dic[@"describe"];
            self.explain = dic[@"explain"];
            self.sampleClass = dic[@"sampleClass"];
            
            CGFloat spacing = 8.0;
            CGSize limitSize = CGSizeMake(Screen_Width - 2*spacing, CGFLOAT_MAX);
            CGFloat titleHeight = [self.title boundingRectWithSize:limitSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: Title_Font} context:nil].size.height;
            _titleRect = CGRectMake(spacing, spacing, limitSize.width, titleHeight);
            CGFloat describeHeight = [self.describe boundingRectWithSize:limitSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: Describe_Font} context:nil].size.height;
            _describeRect = CGRectMake(spacing, spacing + titleHeight + spacing, limitSize.width, titleHeight);
            _cellHeight = spacing + titleHeight + spacing + describeHeight + spacing;
        }
    }
    
    return self;
}

@end
