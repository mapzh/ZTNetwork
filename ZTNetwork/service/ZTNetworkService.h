//
//  ZTNetworkService.h
//  ZTNetworkDemo
//
//  Created by mapengzhen on 16/9/10.
//  Copyright © 2016年 mapengzhen. All rights reserved.
//

#import "ZTNetworkRequest.h"
#import "ZTError.h"

typedef void(^ZTServiceCompletionBlock)(id data);
typedef void(^ZTServiceFailureBlock)(ZTError *error);

@interface ZTNetworkService : ZTNetworkRequest

- (void)sendRequestToUrl:(NSURL *)url
           requestMethod:(NSString *)method
              parameters:(NSDictionary *)params
              completion:(ZTNetworkRequestBasicBlock)completion
                 failure:(ZTNetworkRequestBasicBlock)failure;

- (id)getObjectFromResponse;

- (id)getErrorFromResponse;

@end
