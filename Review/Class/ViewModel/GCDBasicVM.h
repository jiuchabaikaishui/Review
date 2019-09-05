//
//  GCDBasicVM.h
//  Review
//
//  Created by apple on 2019/8/29.
//  Copyright © 2019 QSP. All rights reserved.
//

#import "BaseVM.h"

@interface GCDBasicVM : BaseVM

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong, readonly) RACCommand *buttonRCommand;
@property (nonatomic, strong, readonly) RACCommand *buttonLCommand;
@property (nonatomic, copy, readonly) NSURL *imageURL;
@property (nonatomic, strong) UIImage *image;

@end

NS_ASSUME_NONNULL_BEGIN

NS_ASSUME_NONNULL_END
