//
//  ZTNetworkWrapper.m
//  ZTNetworkDemo
//
//  Created by mapengzhen on 15/12/14.
//  Copyright © 2015年 mapengzhen. All rights reserved.
//

#import "ZTNetworkWrapper.h"

@interface ZTNetworkWrapper()
/**
 *  记录wrapper中所有请求的taskIdentifier
 */
@property (nonatomic,strong) NSMutableArray *_Nullable taskIdentifiers;

@end

@implementation ZTNetworkWrapper

- (instancetype)init
{
    self = [super init];
    if (self) {
        _taskIdentifiers = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self clearAllRequest];
}

- (AFHTTPSessionManager *)sessionManager{
    if (_sessionManager) {
        return _sessionManager;
    }
    return [AFHTTPSessionManager manager];
}

- (void)sendRequestWithUrlString:(nonnull NSString *)urlString requestMethod:(ZT_REQUEST_METHOD)method parameters:(nullable NSDictionary *)parameters completion:(nullable ZT_COMPLETION_BLOCK)completion{
    [self sendRequestWithUrlString:urlString requestMethod:method parameters:parameters progress:nil completion:completion];
}

- (void)sendRequestWithUrlString:(nonnull NSString *)urlString requestMethod:(ZT_REQUEST_METHOD)method parameters:(nullable NSDictionary *)parameters progress:(nullable ZT_PROGRESS_BLOCK) downloadProgress completion:(nullable ZT_COMPLETION_BLOCK)completion{
    AFHTTPSessionManager *manager = self.sessionManager;
    void (^successBlock)(NSURLSessionDataTask * _Nonnull, id  _Nullable) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        if (task) {
            [dict setSafeObject:@(task.state) forKey:URL_SESSION_TASK_STATUS_KEY];
        }
        [dict setSafeObject:responseObject forKey:SUCCESS_DATA_OF_REQUEST];
        if (completion) {
            completion(task,responseObject,nil);
        }
    };
    void (^failBlock)(NSURLSessionDataTask * _Nullable , NSError * _Nonnull) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        if (error&&completion) {
            completion(task,nil,error);
        }
    };
    NSURLSessionDataTask *dataTask = nil;
    if (method==ZT_REQUEST_METHOD_GET) {
        dataTask = [manager GET:urlString parameters:parameters progress:downloadProgress success:successBlock failure:failBlock];
    }else if (method==ZT_REQUEST_METHOD_POST){
        dataTask = [manager POST:urlString parameters:parameters progress:downloadProgress success:successBlock failure:failBlock];
    }
    if (dataTask.taskIdentifier) {
        [self.taskIdentifiers addObject:@(dataTask.taskIdentifier)];
    }
}

- (void)clearAllRequest{
    AFHTTPSessionManager *manager = self.sessionManager;
    for (NSURLSessionTask *task in manager.tasks) {
        if ([self.taskIdentifiers containsObject:@(task.taskIdentifier)]) {
            [task cancel];
        }
    }
}

- (dispatch_group_t)getCurrentApiDGT{
    return [self sessionManager].completionGroup;
}
@end
