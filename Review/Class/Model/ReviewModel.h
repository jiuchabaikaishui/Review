//
//  ReviewModel.h
//  Review
//
//  Created by apple on 17/5/26.
//  Copyright © 2017年 QSP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define Title_Font              [UIFont systemFontOfSize:16]
#define Describe_Font           [UIFont systemFontOfSize:13]

@interface ReviewModel : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *describe;
@property (copy,nonatomic) NSString *explain;
@property (copy,nonatomic) NSString *sampleClass;

@property (assign, nonatomic, readonly) CGRect titleRect;
@property (assign, nonatomic, readonly) CGRect describeRect;
@property (assign, nonatomic, readonly) CGFloat cellHeight;

+ (instancetype)reviewModelWithDic:(NSDictionary *)dic;
- (instancetype)initWithDic:(NSDictionary *)dic;

@end
