//
//  MD5VM.h
//  Review
//
//  Created by apple on 2019/8/13.
//  Copyright © 2019 QSP. All rights reserved.
//

#import "BaseVM.h"

@interface MD5VM : BaseVM

@property (nonatomic, strong, readonly) RACCommand *button16Command;
@property (nonatomic, strong, readonly) RACCommand *button32Command;

- (NSString *)md5_32:(NSString *)text upperCase:(BOOL)uppuerCase;
- (NSString *)md5_16:(NSString *)text upperCase:(BOOL)uppuerCase;

@end

NS_ASSUME_NONNULL_BEGIN

NS_ASSUME_NONNULL_END
