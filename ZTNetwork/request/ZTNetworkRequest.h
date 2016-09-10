//
//  ZTNetworkRequest.h
//  ZTNetworkDemo
//
//  Created by mapengzhen on 16/9/10.
//  Copyright © 2016年 mapengzhen. All rights reserved.
//
#import "ZTNetworkProtocol.h"
#import "AFNetworking.h"

extern NSString *const ZTNetworkRequestMethodGet;
extern NSString *const ZTNetworkRequestMethodPost;
extern NSString *const ZTNetworkRequestMethodPut;
extern NSString *const ZTNetworkRequestMethodDelete;
extern NSString *const ZTNetworkRequestMethodHEAD;
extern NSString *const ZTNetworkServiceMethod;



@protocol ZTNetworkRequestDelegate <NSObject>

@optional

- (void)requestFinished:(id)request;
- (void)requestFailed:(id)request;
- (NSURLRequest*)redirectRequestForRequest:(NSURLRequest*) request;

@end



typedef void(^ZTNetworkRequestBasicBlock)(void);

@interface ZTNetworkRequest : NSObject<ZTNetworkProtocol>

@property (nonatomic, strong) AFHTTPSessionManager *sessioManager;

@property(nonatomic, strong) NSURLRequest *request;

@property (nonatomic, copy) ZTNetworkRequestBasicBlock completionBlock;

@property (nonatomic, copy) ZTNetworkRequestBasicBlock failureBlock;

//请求参数
@property (nonatomic, strong) NSMutableDictionary *parameters;


//重置cookie
- (void)resetCookies;



#pragma mark-ZTNetworkProtocol protocol imp
@property(nonatomic, strong) NSURL* url;
@property (nonatomic, weak) id<ZTNetworkRequestDelegate> delegate;
@property (nonatomic, copy) NSString *requestMethod;
@property (nonatomic, strong) NSMutableDictionary *requestHeaders;
@property (nonatomic, strong) NSMutableArray *requestCookies;
@property (nonatomic, strong) NSDictionary *responseHeaders;
@property (nonatomic, assign) BOOL allowCompressedResponse;
@property (nonatomic, assign) NSTimeInterval timeOutSeconds;
@property (nonatomic, copy) NSString *responseString;
@property (nonatomic, strong) NSData *responseData;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, assign) NSInteger responseStatusCode;
@property (nonatomic, strong) NSArray *clientCertificates;
@property (nonatomic, assign) BOOL cancelled;
@property (nonatomic, assign) int numberOfTimesToRetryOnTimeout;
@end
