//
//  NotificationVM.h
//  Review
//
//  Created by 綦帅鹏 on 2018/11/13.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "BaseVM.h"

NS_ASSUME_NONNULL_BEGIN

@interface NotificationVM : BaseVM

@property (nonatomic, strong) RACCommand *addCommand;
@property (nonatomic, strong) RACCommand *postCommand;
@property (nonatomic, strong) RACCommand *removeCommand;

@end

NS_ASSUME_NONNULL_END
