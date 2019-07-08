//
//  CoordinateView.m
//  Review
//
//  Created by 綦帅鹏 on 2019/6/27.
//  Copyright © 2019 QSP. All rights reserved.
//

#import "CoordinateView.h"

#define CV_Margin           8.0f
#define CV_Color            [UIColor blackColor]
#define CV_ParagraphStyle   ({\
                                NSMutableParagraphStyle *alignmentCParagraphStyle = [[NSMutableParagraphStyle alloc] init];\
                                alignmentCParagraphStyle.alignment = NSTextAlignmentCenter;\
                                alignmentCParagraphStyle;\
                            })
#define CV_Attributes       @{NSFontAttributeName: [UIFont systemFontOfSize:8], NSForegroundColorAttributeName: CV_Color, NSParagraphStyleAttributeName: CV_ParagraphStyle}
#define CV_Scale_W          3.0f
#define CV_Line_W           1.0f
#define CV_Key_X            @"数值"
#define CV_Key_Y            @"位置"
#define CV_Arrow            @"➤"
#define CV_Arrow_Size       [CV_Arrow boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:CV_Attributes context:nil].size
#define CV_Value_X          10
#define CV_Value_Y          10
#define CV_Lable_Size       CGSizeMake(20.0f, 10.0f)

@interface CoordinateView ()

@property (nonatomic, assign, readonly) int maxX;
@property (nonatomic, assign, readonly) int maxY;

@end

@implementation CoordinateView

- (void)setLabelX:(NSString *)labelX {
    _labelX = [labelX copy];
    [self setNeedsDisplay];
}
- (void)setLabelY:(NSString *)labelY {
    _labelY = [labelY copy];
    [self setNeedsDisplay];
}


+ (instancetype)coordinateWithMaxX:(int)maxX maxY:(int)maxY {
    return [[self alloc] initWithMaxX:maxX maxY:maxY];
}
- (instancetype)initWithMaxX:(int)maxX maxY:(int)maxY {
    if (self = [super init]) {
        _maxX = maxX;
        _maxY = maxY;
    }
    
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self defaultSetting];
    }
    
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self defaultSetting];
    }
    
    return self;
}
- (void)defaultSetting {
    self.backgroundColor = [UIColor whiteColor];
    self.labelX = CV_Key_X;
    self.labelY = CV_Key_Y;
    _maxX = CV_Value_X;
    _maxY = CV_Value_Y;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    [self drawX:rect context:ref];
    
    [self drawY:rect context:ref];
}
- (void)drawX:(CGRect)rect context:(CGContextRef)context {
    CGContextMoveToPoint(context, 2*CV_Margin + CV_Lable_Size.width, rect.size.height - 2*CV_Margin - CV_Lable_Size.height);
    CGContextAddLineToPoint(context, rect.size.width - CV_Margin, rect.size.height - 2*CV_Margin - CV_Lable_Size.height);
    [self.labelX drawInRect:CGRectMake(rect.size.width - CV_Lable_Size.width, rect.size.height - CV_Margin - CV_Lable_Size.height, CV_Lable_Size.width, CV_Lable_Size.height) withAttributes:CV_Attributes];
    
    CGFloat xScale = floorf((rect.size.width - 3*CV_Margin - CV_Lable_Size.width)/(self.maxX + 1));
    for (int i = 0; i < self.maxX; i++) {
        CGFloat X = 2*CV_Margin + CV_Lable_Size.width + xScale*(1 + i);
        CGContextMoveToPoint(context, X, rect.size.height - 2*CV_Margin - CV_Lable_Size.height);
        CGContextAddLineToPoint(context, X, rect.size.height - 2*CV_Margin - CV_Lable_Size.height - CV_Scale_W);
        
        NSString *str = [NSString stringWithFormat:@"%i", i + 1];
        [str drawInRect:CGRectMake(X - CV_Lable_Size.width/2, rect.size.height - CV_Margin - CV_Lable_Size.height, CV_Lable_Size.width, CV_Lable_Size.height) withAttributes:CV_Attributes];
    }
    [CV_Color setFill];
    CGContextSetLineWidth(context, CV_Line_W);
    CGContextStrokePath(context);
    
    [CV_Arrow drawInRect:CGRectMake(rect.size.width - CV_Margin - CV_Arrow_Size.width/2, rect.size.height - 2*CV_Margin - CV_Lable_Size.height - CV_Arrow_Size.height/2, CV_Arrow_Size.width, CV_Arrow_Size.height) withAttributes:CV_Attributes];
}
- (void)drawY:(CGRect)rect context:(CGContextRef)context {
    CGContextMoveToPoint(context, 2*CV_Margin + CV_Lable_Size.width, rect.size.height - 2*CV_Margin - CV_Lable_Size.height);
    CGContextAddLineToPoint(context, 2*CV_Margin + CV_Lable_Size.width, CV_Margin);
    [self.labelY drawInRect:CGRectMake(CV_Margin, CV_Lable_Size.height/2, CV_Lable_Size.width, CV_Lable_Size.height) withAttributes:CV_Attributes];
    
    CGFloat yScale = floorf((rect.size.height - 3*CV_Margin - CV_Lable_Size.height)/(self.maxY + 1));
    for (int i = 0; i < self.maxY; i++) {
        CGFloat Y = rect.size.height - 2*CV_Margin - CV_Lable_Size.height - yScale*(1 + i);
        CGContextMoveToPoint(context, 2*CV_Margin + CV_Lable_Size.width, Y);
        CGContextAddLineToPoint(context, 2*CV_Margin + CV_Lable_Size.width + CV_Scale_W, Y);
        
        NSString *str = [NSString stringWithFormat:@"%i", i + 1];
        [str drawInRect:CGRectMake(CV_Margin, Y - CV_Lable_Size.height/2, CV_Lable_Size.width, CV_Lable_Size.height) withAttributes:CV_Attributes];
    }
    [CV_Color setFill];
    CGContextSetLineWidth(context, CV_Line_W);
    CGContextStrokePath(context);
    
    CGContextRotateCTM(context, -M_PI_2);
    CGContextTranslateCTM(context, -rect.size.height, 0.0);
    [CV_Arrow drawInRect:CGRectMake(rect.size.height - CV_Margin - CV_Arrow_Size.width/2, 2*CV_Margin + CV_Lable_Size.width - CV_Arrow_Size.height/2, CV_Arrow_Size.width, CV_Arrow_Size.height) withAttributes:CV_Attributes];
}

- (CGPoint)positionFromeValueX:(int)x valueY:(int)y {
    CGFloat xScale = floorf((self.frame.size.width - 3*CV_Margin - CV_Lable_Size.width)/(self.maxX + 1));
    CGFloat yScale = floorf((self.frame.size.height - 3*CV_Margin - CV_Lable_Size.height)/(self.maxY + 1));
    return CGPointMake(2*CV_Margin + CV_Lable_Size.width + x*xScale, self.bounds.size.height - 2*CV_Margin - CV_Lable_Size.height - y*yScale);
}
- (CGFloat)xFormValueX:(int)x {
    CGFloat xScale = floorf((self.frame.size.width - 3*CV_Margin - CV_Lable_Size.width)/(self.maxX + 1));
    return 2*CV_Margin + CV_Lable_Size.width + x*xScale;
}
- (CGFloat)yFormValueY:(int)y {
    CGFloat yScale = floorf((self.frame.size.height - 3*CV_Margin - CV_Lable_Size.height)/(self.maxY + 1));
    return self.bounds.size.height - 2*CV_Margin - CV_Lable_Size.height - y*yScale;
}

@end
