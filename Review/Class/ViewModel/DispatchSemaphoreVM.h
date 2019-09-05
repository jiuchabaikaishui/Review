//
//  DispatchSemaphoreVM.h
//  Review
//
//  Created by apple on 2019/8/30.
//  Copyright © 2019 QSP. All rights reserved.
//

#import "BaseVM.h"

@interface DispatchSemaphoreVM : BaseVM

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong, readonly) RACCommand *buttonCommand;

@end

NS_ASSUME_NONNULL_BEGIN

NS_ASSUME_NONNULL_END
