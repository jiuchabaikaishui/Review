//
//  QSPScrollViewVM.h
//  MiningInterestingly
//
//  Created by QSP on 2018/8/22.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "QSPViewVM.h"

@interface QSPScrollViewVM : QSPViewVM<UIScrollViewDelegate>

@property (strong, nonatomic, readonly) RACSignal *didScrollSignal;
//@property (strong, nonatomic, readonly) RACSignal *didZoomSignal;
//@property (strong, nonatomic, readonly) RACSignal *willBeginDraggingSignal;
//@property (strong, nonatomic, readonly) RACSignal *willEndDraggingSignal;
//@property (strong, nonatomic, readonly) RACSignal *didEndDraggingSignal;
//@property (strong, nonatomic, readonly) RACSignal *willBeginDeceleratingSignal;
@property (strong, nonatomic, readonly) RACSignal *didEndDeceleratingSignal;

@end
