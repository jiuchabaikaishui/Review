//
//  AESVM.m
//  Review
//
//  Created by apple on 2019/8/13.
//  Copyright © 2019 QSP. All rights reserved.
//

#import "AESVM.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation AESVM
@synthesize buttonECommand = _buttonECommand;
@synthesize buttonDCommand = _buttonDCommand;

- (RACCommand *)buttonECommand {
    if (_buttonECommand == nil) {
        _buttonECommand = [self emptyCommand];
    }
    
    return _buttonECommand;
}
- (RACCommand *)buttonDCommand {
    if (_buttonDCommand == nil) {
        _buttonDCommand = [self emptyCommand];
    }
    
    return _buttonDCommand;
}

// 对NSData加密
- (NSData *)AESEncryptWithData:(NSData *)data Key:(NSString *)key
{
    char keyPtr[kCCKeySizeAES128 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    char ivPtr[kCCBlockSizeAES128 + 1];
    memset(ivPtr, 0, sizeof(ivPtr));
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          ivPtr,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    
    if(cryptStatus == kCCSuccess)
    {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    
    return nil;
}

// 对NSData解密
- (NSData *)AESDecryptWithData:(NSData *)data andKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES128 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding | kCCOptionECBMode, keyPtr, kCCBlockSizeAES128, NULL, [data bytes], dataLength, buffer, bufferSize, &numBytesDecrypted);
    
    if(cryptStatus == kCCSuccess)
    {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer);
    
    return nil;
}

// 对NSString加密（实际上是先把字符串转化为NSData进行加密，再把加密后的NSData转化为字符串）
- (NSString *)AESEncryptWithString:(NSString *)string andKey:(NSString *)key
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    //对数据进行加密
    NSData *result = [self AESEncryptWithData:data Key:key];
    NSLog(@"%@", result);
    
    NSData *endData = [result base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return [[NSString alloc] initWithData:endData encoding:NSUTF8StringEncoding];
}

// 对NSString解密（实际上是先把字符串转化为NSData进行解密，再把解密后的NSData转化为字符串）
- (NSString *)AESDecryptWithString:(NSString *)string andKey:(NSString *)key
{
    NSData *result = [self AESDecryptWithData:[[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters] andKey:key];
    if(result && result.length > 0)
    {
        NSString *str = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
        
        return str;
    }
    
    return nil;
}

@end
