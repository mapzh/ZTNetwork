//
//  ZTNetworkRequestManager.m
//  ZTNetworkDemo
//
//  Created by natural on 16/9/10.
//  Copyright © 2016年 mapengzhen. All rights reserved.
//

#import "ZTNetworkRequestManager.h"
#import "ZTNetworkRequest.h"

@implementation ZTNetworkRequestManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.requests = [[NSMutableSet alloc] init];
    }
    return self;
}

+ (instancetype)sharedManager{
    static ZTNetworkRequestManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[[self class] alloc] init];
    });
    return sharedManager;
}

- (void)addRequest:(ZTNetworkRequest *)request{
    if ([request isKindOfClass:[ZTNetworkRequest class]]) {
        [self.requests addObject:request];
    }
}

- (void)clearAllRequests{
    for (ZTNetworkRequest *request in self.requests) {
        if ([request isKindOfClass:[ZTNetworkRequest class]]&&[request respondsToSelector:@selector(cancel)]) {
            [request cancel];
        }
    }
    [self.requests removeAllObjects];
}

@end
