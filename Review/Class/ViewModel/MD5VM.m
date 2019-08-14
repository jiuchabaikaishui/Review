//
//  MD5VM.m
//  Review
//
//  Created by apple on 2019/8/13.
//  Copyright © 2019 QSP. All rights reserved.
//

#import "MD5VM.h"
#import <CommonCrypto/CommonDigest.h>

@implementation MD5VM
@synthesize button16Command = _button16Command;
@synthesize button32Command = _button32Command;

- (RACCommand *)button16Command {
    if (_button16Command == nil) {
        _button16Command = [self emptyCommand];
    }
    
    return _button16Command;
}
- (RACCommand *)button32Command {
    if (_button32Command == nil) {
        _button32Command = [self emptyCommand];
    }
    
    return _button32Command;
}

- (NSString *)md5_32:(NSString *)text upperCase:(BOOL)uppuerCase {
    // 1、转化为UTF8字符串
    const char *chars = [text UTF8String];
    // 2、设置一个接收字符数组
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    // 3、把str字符串转换成为32位的16进制数列，存到result中
    CC_MD5(chars, (int)strlen(chars), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:1];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        // 4、将16字节的16进制转成32字节的16进制字符串
        [result appendFormat:@"%02x", digest[i]];
    }
    
    if (uppuerCase) {
        return [result uppercaseString];
    } else {
        return [result lowercaseString];
    }
}
- (NSString *)md5_16:(NSString *)text upperCase:(BOOL)uppuerCase  {
    NSString *md5_32 = [self md5_32:text upperCase:uppuerCase];
    
    // 从32位中提取9~24位
    return [[md5_32 substringToIndex:24] substringFromIndex:8];
}

@end
