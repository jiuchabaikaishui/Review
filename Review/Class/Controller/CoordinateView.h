//
//  CoordinateView.h
//  Review
//
//  Created by 綦帅鹏 on 2019/6/27.
//  Copyright © 2019 QSP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoordinateView : UIView

@property (nonatomic, copy) NSString *labelX;
@property (nonatomic, copy) NSString *labelY;

+ (instancetype)coordinateWithMaxX:(int)maxX maxY:(int)maxY;
- (instancetype)initWithMaxX:(int)maxX maxY:(int)maxY;

- (CGPoint)positionFromeValueX:(int)x valueY:(int)y;
- (CGFloat)xFormValueX:(int)x;
- (CGFloat)yFormValueY:(int)y;

@end

NS_ASSUME_NONNULL_BEGIN

NS_ASSUME_NONNULL_END
