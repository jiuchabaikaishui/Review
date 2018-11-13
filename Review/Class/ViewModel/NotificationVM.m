//
//  NotificationVM.m
//  Review
//
//  Created by 綦帅鹏 on 2018/11/13.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "NotificationVM.h"

@implementation NotificationVM

- (RACCommand *)addCommand {
    if (_addCommand == nil) {
        _addCommand = [self emptyCommand];
    }
    
    return _addCommand;
}
- (RACCommand *)postCommand {
    if (_postCommand == nil) {
        _postCommand = [self emptyCommand];
    }
    
    return _postCommand;
}
- (RACCommand *)removeCommand {
    if (_removeCommand == nil) {
        _removeCommand = [self emptyCommand];
    }
    
    return _removeCommand;
}

@end
