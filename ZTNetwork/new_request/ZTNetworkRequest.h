//
//  ZTNetworkRequest.h
//  ZTNetworkDemo
//
//  Created by mapengzhen on 16/9/10.
//  Copyright © 2016年 mapengzhen. All rights reserved.
//
#import "ZTNetworkProtocol.h"

extern NSString *const ZTNetworkRequestMethodGet;
extern NSString *const ZTNetworkRequestMethodPost;
extern NSString *const ZTNetworkRequestMethodPut;
extern NSString *const ZTNetworkRequestMethodDelete;
extern NSString *const ZTNetworkRequestMethodHEAD;
extern NSString *const ZTNetworkServiceMethod;

@interface ZTNetworkRequest : NSObject<ZTNetworkProtocol>


@end
