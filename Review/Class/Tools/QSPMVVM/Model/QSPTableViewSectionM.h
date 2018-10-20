//
//  QSPTableViewSectionM.h
//  ThreadingPrograming
//
//  Created by QSP on 2018/7/23.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol QSPTableViewSectionMDelegate<NSObject>

@optional
@property (copy, nonatomic, readonly) NSString *headerTitle;
@property (copy, nonatomic, readonly) NSString *footerTitle;
@property (copy, nonatomic, readonly) NSString *headerDetail;
@property (copy, nonatomic, readonly) NSString *footerDetail;

@end

@interface QSPTableViewSectionM : NSObject<QSPTableViewSectionMDelegate>

@property (copy, nonatomic, readonly) NSString *headerTitle;
@property (copy, nonatomic, readonly) NSString *footerTitle;
@property (copy, nonatomic, readonly) NSString *headerDetail;
@property (copy, nonatomic, readonly) NSString *footerDetail;

@end
