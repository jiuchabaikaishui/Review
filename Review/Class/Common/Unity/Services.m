//
//  Services.m
//  Review
//
//  Created by apple on 2019/8/30.
//  Copyright © 2019 QSP. All rights reserved.
//

#import "Services.h"
#import "AFNetworking.h"

@implementation Services

+ (void)news:(void (^)(id responseObject, NSError *error))completion {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    [manager GET:@"https://www.apiopen.top/journalismApi" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}
+ (void)weatherOfCity:(NSString *)city completion:(void (^)(id responseObject, NSError *error))completion {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    [manager GET:@"https://www.apiopen.top/weatherApi" parameters:@{@"city": city} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}
+ (void)namesOfPage:(int)page completion:(void (^)(id responseObject, NSError *error))completion {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    [manager GET:@"https://www.apiopen.top/femaleNameApi" parameters:@{@"page": @(page)} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

@end
