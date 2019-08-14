//
//  AESVM.h
//  Review
//
//  Created by apple on 2019/8/13.
//  Copyright © 2019 QSP. All rights reserved.
//

#import "BaseVM.h"

#define kAES_Key   @"0123456789ABCDEF"

@interface AESVM : BaseVM

@property (nonatomic, strong, readonly) RACCommand *buttonECommand;
@property (nonatomic, strong, readonly) RACCommand *buttonDCommand;

//对NSData 进行加密
- (NSData *)AESEncryptWithData:(NSData *)data Key:(NSString *)key;
// 解密
- (NSData *)AESDecryptWithData:(NSData *)data andKey:(NSString *)key;
- (NSString *)AESEncryptWithString:(NSString *)string andKey:(NSString *)key;
- (NSString *)AESDecryptWithString:(NSString *)string andKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_BEGIN

NS_ASSUME_NONNULL_END
