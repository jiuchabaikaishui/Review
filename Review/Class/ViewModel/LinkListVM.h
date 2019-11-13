//
//  LinkListVM.h
//  Review
//
//  Created by apple on 2019/9/27.
//  Copyright © 2019 QSP. All rights reserved.
//

#import "BaseVM.h"

@interface LinkListVM : BaseVM
@property (strong, nonatomic, readonly) RACCommand *loopLogCommand;
@property (strong, nonatomic, readonly) RACCommand * recursiveLogCommand;
@property (strong, nonatomic, readonly) RACCommand *loopReverseCommand;
@property (strong, nonatomic, readonly) RACCommand * recursiveReverseCommand;

@end

NS_ASSUME_NONNULL_BEGIN

NS_ASSUME_NONNULL_END
