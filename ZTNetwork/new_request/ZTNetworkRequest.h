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

@property (nonatomic, weak) id<ZTNetworkRequestDelegate> delegate;

@property (nonatomic, copy) ZTNetworkRequestBasicBlock completionBlock;

@property (nonatomic, copy) ZTNetworkRequestBasicBlock failureBlock;

//请求参数
@property (nonatomic, strong) NSMutableDictionary *parameters;

- (instancetype)initWithUrl:(NSURL *)url;

//重置cookie
- (void)resetCookies;
@end
