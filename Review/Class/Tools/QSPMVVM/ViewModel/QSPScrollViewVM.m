//
//  QSPScrollViewVM.m
//  MiningInterestingly
//
//  Created by QSP on 2018/8/22.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "QSPScrollViewVM.h"

@interface QSPScrollViewVM ()

@property (weak, nonatomic) id<RACSubscriber> didSelectRowSubscriber;

@property (weak, nonatomic) id<RACSubscriber> didScrollSubscriber;
@property (weak, nonatomic) id<RACSubscriber> didZoomSubscriber;
@property (weak, nonatomic) id<RACSubscriber> willBeginDraggingSubscriber;
@property (weak, nonatomic) id<RACSubscriber> willEndDraggingSubscriber;
@property (weak, nonatomic) id<RACSubscriber> didEndDraggingSubscriber;
@property (weak, nonatomic) id<RACSubscriber> willBeginDeceleratingSubscriber;
@property (weak, nonatomic) id<RACSubscriber> didEndDeceleratingSubscriber;

@end

@implementation QSPScrollViewVM

- (instancetype)init {
    if (self = [super init]) {
        _didScrollSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            self.didScrollSubscriber = subscriber;
            return [RACDisposable disposableWithBlock:^{
                [subscriber sendCompleted];
            }];
        }];
        _didEndDeceleratingSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            self.didEndDeceleratingSubscriber = subscriber;
            return [RACDisposable disposableWithBlock:^{
                [subscriber sendCompleted];
            }];
        }];
    }
    
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.didScrollSubscriber sendNext:scrollView];
}
//- (void)scrollViewDidZoom:(UIScrollView *)scrollView NS_AVAILABLE_IOS(3_2) {
//
//}
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//
//}
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0) {
//
//}
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//
//}
//- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
//
//}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self.didEndDeceleratingSubscriber sendNext:scrollView];
}

@end
