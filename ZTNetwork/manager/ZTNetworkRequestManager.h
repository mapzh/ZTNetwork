//
//  ZTNetworkRequestManager.h
//  ZTNetworkDemo
//
//  Created by natural on 16/9/10.
//  Copyright © 2016年 mapengzhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZTNetworkExceptionMonitor.h"

@class ZTNetworkRequest;

/*
 * request管理类，所有请求记录在此类对象中
 */
@interface ZTNetworkRequestManager : NSObject
@property (nonatomic, strong) NSMutableSet<ZTNetworkRequest *> *requests;
@property (nonatomic, strong) ZTNetworkExceptionMonitor *exceptionMonitor;

+ (instancetype)sharedManager;

//每初始化一个ZTNetworkRequest，加入self.requests
- (void)addRequest:(ZTNetworkRequest *)request;

//取消所有网络请求
- (void)clearAllRequests;

@end
