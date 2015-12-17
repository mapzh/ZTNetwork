//
//  ZTNetworkWrapper.h
//  ZTNetworkDemo
//
//  Created by mapengzhen on 15/12/14.
//  Copyright © 2015年 mapengzhen. All rights reserved.
//
#define SUCCESS_DATA_OF_REQUEST @"success_data_of_request"
#define URL_SESSION_TASK_STATUS_KEY @"zt_url_session_task_status"

#import <Foundation/Foundation.h>

typedef void(^ZT_COMPLETION_BLOCK)(NSURLSessionDataTask *_Nullable response, id _Nullable responseObject, NSError *_Nullable error);

typedef enum{
    ZT_REQUEST_METHOD_GET = 0,
    ZT_REQUEST_METHOD_POST
}ZT_REQUEST_METHOD;

#import <AFNetworking/AFHTTPSessionManager.h>
@interface ZTNetworkWrapper : NSObject

/**
 *  发起请求
 *
 *  @param urlString  请求地址
 *  @param method     GET or POST
 *  @param parameters 请求参数
 *  @param completion 请求完成执行block
 */
- (void)sendRequestWithUrlString:(nonnull NSString *)urlString requestMethod:(ZT_REQUEST_METHOD)method parameters:(nullable NSDictionary *)parameters completion:(nullable ZT_COMPLETION_BLOCK)completion;

/**
 *  清除self生成的所有请求
 */
- (void)clearAllRequest;
@end
