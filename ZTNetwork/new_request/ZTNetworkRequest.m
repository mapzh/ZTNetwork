//
//  ZTNetworkRequest.m
//  ZTNetworkDemo
//
//  Created by mapengzhen on 16/9/10.
//  Copyright © 2016年 mapengzhen. All rights reserved.
//

#import "ZTNetworkRequest.h"
#import "ZTCommonFunction.h"
#import "ZTSafeDictionnary.h"

NSString *const ZTNetworkRequestMethodGet = @"GET";
NSString *const ZTNetworkRequestMethodPost = @"POST";
NSString *const ZTNetworkRequestMethodPut = @"PUT";
NSString *const ZTNetworkRequestMethodDelete = @"DELETE";
NSString *const ZTNetworkRequestMethodHEAD = @"HEAD";
NSString *const ZTNetworkServiceMethod = @"serviceMethod";

@interface ZTNetworkRequest()
@property (nonatomic, strong) NSURLSessionDataTask *operation;

@end

@implementation ZTNetworkRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sessioManager = [AFHTTPSessionManager manager];
        self.requestHeaders = [[NSMutableDictionary alloc] initWithCapacity:10];
        self.requestMethod = ZTNetworkRequestMethodGet;
        self.timeOutSeconds = 15;
        self.clientCertificates = nil;
    }
    return self;
}

- (instancetype)initWithUrl:(NSURL *)url{
    self = [[[self class] alloc] init];
    self.url = url;

    return self;
}

+ (id)requestWithURL:(NSURL *)newURL{
    return [[[self class] alloc] initWithUrl:newURL];
}

- (void)startAsynchronous{
    __weak ZTNetworkRequest *instance = self;
    if (isNotEmptyArray(self.clientCertificates)) {
        NSSet *certSet = [NSSet setWithArray:self.clientCertificates];
        //加载.cer证书
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        [securityPolicy setPinnedCertificates:certSet];
        self.sessioManager.securityPolicy = securityPolicy;
    }else{
        self.sessioManager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    }
    for (NSString *key in self.requestHeaders) {
        NSString *value = [self.requestHeaders stringValueForKey:key];
        [self.sessioManager.requestSerializer setValue:value forHTTPHeaderField:key];
    }
    //设置超时
    self.sessioManager.requestSerializer.timeoutInterval = self.timeOutSeconds;
    self.sessioManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    if ([self.requestMethod isEqualToString:ZTNetworkRequestMethodGet]) {
        self.operation = [self.sessioManager GET:self.url.absoluteString parameters:self.parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [instance completion:task rep:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [instance failed:task error:error];
        }];
    }else if ([self.requestMethod isEqualToString:ZTNetworkRequestMethodPost]){
        
    }else if ([self.requestMethod isEqualToString:ZTNetworkRequestMethodPut]){
        
    }else if ([self.requestMethod isEqualToString:ZTNetworkRequestMethodDelete]){
        
    }
}

- (void) didCompletion {
    if (self.delegate && [self.delegate respondsToSelector:@selector(requestFinished:)]) {
        [self.delegate requestFinished:self];
    }
    
    if (self.completionBlock) {
        self.completionBlock();
    }
}

- (void)completion:(NSURLSessionDataTask *)operation rep: (id)responseObject {
    NSHTTPURLResponse *response = (NSHTTPURLResponse*) self.operation.response;
    self.responseStatusCode = response.statusCode;
    self.responseData = responseObject;
    self.responseHeaders = [response allHeaderFields];
    __weak ZTNetworkRequest *instance = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        self.responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            [instance didCompletion];
        });
    });
}

- (void)failed:(NSURLSessionDataTask *)operation error: (NSError*)error {
    self.error = operation.error;
    
    if ([operation.response isKindOfClass:[NSHTTPURLResponse class]]) {
        self.responseStatusCode = ((NSHTTPURLResponse *)operation.response).statusCode;
    }
    
    if (error.code == NSURLErrorCancelled) {
        self.cancelled = YES;
    }
    
    if (error.code == NSURLErrorTimedOut) {
        
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(requestFailed:)]) {
        [self.delegate requestFailed:self];
    }
    
    if (self.failureBlock) {
        self.failureBlock();
    }
}


- (void)resetCookies{
    NSString *headerHost = [self.requestHeaders objectForKey:@"Host"];
    NSString *urlHost = self.url.host;
    if (!isNotEmptyString(headerHost)) {
        return;
    }
    
    if (!isNotEmptyString(urlHost)) {
        return;
    }
    NSString *urlString = self.url.absoluteString;
    urlString = [urlString stringByReplacingOccurrencesOfString:urlHost withString:headerHost];
    NSURL* retUrl = [NSURL URLWithString:urlString];
    
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:retUrl];
    if (isNotEmptyArray(cookies)) {
        
        NSDictionary *cookieInfo = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
        NSString *cookieHeader = [cookieInfo stringValueForKey:@"Cookie"];
        if (isNotEmptyString(cookieHeader)) {
            [self.sessioManager.requestSerializer setValue:cookieHeader forHTTPHeaderField:@"Cookie"];
        }
    }
}

@end
