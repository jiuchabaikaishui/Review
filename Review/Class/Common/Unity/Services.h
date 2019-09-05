//
//  Services.h
//  Review
//
//  Created by apple on 2019/8/30.
//  Copyright © 2019 QSP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Services : NSObject

/**
 获取新闻信息

 @param completion 完成的block
 */
+ (void)news:(void (^)(id responseObject, NSError *error))completion;

/**
 查询天气

 @param city 城市
 @param completion 完成的block
 */
+ (void)weatherOfCity:(NSString *)city completion:(void (^)(id responseObject, NSError *error))completion;

/**
 个性网名查询

 @param page 页码
 @param completion 完成的block
 */
+ (void)namesOfPage:(int)page completion:(void (^)(id responseObject, NSError *error))completion;

@end

NS_ASSUME_NONNULL_BEGIN

NS_ASSUME_NONNULL_END
