//
//  DigestCryptor.h
//  Review
//
//  Created by apple on 2019/8/14.
//  Copyright © 2019 QSP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DigestCryptor : NSObject

+ (NSString *)md5_32:(NSString *)text upperCase:(BOOL)uppuerCase;
+ (NSString *)md5_16:(NSString *)text upperCase:(BOOL)uppuerCase;

//对NSData 进行加密
+ (NSData *)AESEncryptWithData:(NSData *)data Key:(NSString *)key;
// 解密
+ (NSData *)AESDecryptWithData:(NSData *)data andKey:(NSString *)key;
+ (NSString *)AESEncryptWithString:(NSString *)string andKey:(NSString *)key;
+ (NSString *)AESDecryptWithString:(NSString *)string andKey:(NSString *)key;


/**
 *  加密方法
 *
 *  @param str   需要加密的字符串
 *  @param path  '.der'格式的公钥文件路径
 */
+ (NSString *)encryptString:(NSString *)str publicKeyWithContentsOfFile:(NSString *)path;
/**
 *  解密方法
 *
 *  @param str       需要解密的字符串
 *  @param path      '.p12'格式的私钥文件路径
 *  @param password  私钥文件密码
 */
+ (NSString *)decryptString:(NSString *)str privateKeyWithContentsOfFile:(NSString *)path password:(NSString *)password;
/**
 *  加密方法
 *
 *  @param str    需要加密的字符串
 *  @param pubKey 公钥字符串
 */
+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;
/**
 *  解密方法
 *
 *  @param str     需要解密的字符串
 *  @param privKey 私钥字符串
 */
+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey;


@end

NS_ASSUME_NONNULL_BEGIN

NS_ASSUME_NONNULL_END
