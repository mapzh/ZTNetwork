//
//  ZTNetworkWrapper.h
//  ZTNetworkDemo
//
//  Created by mapengzhen on 15/12/14.
//  Copyright © 2015年 mapengzhen. All rights reserved.
//
#define SUCCESS_DATA_OF_REQUEST @"success_data_of_request"
#define URL_SESSION_TASK_STATUS_KEY @"zt_url_session_task_status"

#import <ZTCore/ZTCore.h>

typedef void(^ZT_COMPLETION_BLOCK)(NSURLSessionDataTask *_Nullable response, id _Nullable responseObject, NSError *_Nullable error);
typedef void(^ZT_PROGRESS_BLOCK)(NSProgress *_Nullable progress);

typedef enum{
    ZT_REQUEST_METHOD_GET = 0,
    ZT_REQUEST_METHOD_POST
}ZT_REQUEST_METHOD;

#import <AFNetworking/AFHTTPSessionManager.h>
@interface ZTNetworkWrapper : NSObject

/**
 *  若未赋值，则取[AFHTTPSessionManager manager]
 */
@property (nonatomic,strong) AFHTTPSessionManager *_Nullable sessionManager;

/**
 *  发起请求（GET、POST）
 *
 *  @param urlString  请求地址
 *  @param method     GET or POST
 *  @param parameters 请求参数
 *  @param completion 请求完成执行block
 */
- (void)sendRequestWithUrlString:(nonnull NSString *)urlString requestMethod:(ZT_REQUEST_METHOD)method parameters:(nullable NSDictionary *)parameters completion:(nullable ZT_COMPLETION_BLOCK)completion;

/**
 *  发起可感知进度的请求（GET、POST）
 *
 *  @param urlString  请求地址
 *  @param method     GET or POST
 *  @param parameters 请求参数
 *  @param downloadProgress 感知到请求进度后执行的block
 *  @param completion 请求完成执行block
 */
- (void)sendRequestWithUrlString:(nonnull NSString *)urlString requestMethod:(ZT_REQUEST_METHOD)method parameters:(nullable NSDictionary *)parameters progress:(nullable ZT_PROGRESS_BLOCK) downloadProgress completion:(nullable ZT_COMPLETION_BLOCK)completion;

/**
 *  清除self生成的所有请求
 */
- (void)clearAllRequest;

- (dispatch_group_t)getCurrentApiDGT;
@end
