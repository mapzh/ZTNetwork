//
//  ZTNetworkService.m
//  ZTNetworkDemo
//
//  Created by mapengzhen on 16/9/10.
//  Copyright © 2016年 mapengzhen. All rights reserved.
//

#import "ZTNetworkService.h"

@implementation ZTNetworkService

- (void)sendRequestToUrl:(NSURL *)url
           requestMethod:(NSString *)method
              parameters:(NSDictionary *)params
              completion:(ZTNetworkRequestBasicBlock)completion
                 failure:(ZTNetworkRequestBasicBlock)failure{
    self.url = url;
    self.requestMethod = method;
    self.parameters = [NSMutableDictionary dictionaryWithDictionary:params];
    [self setCompletionBlock:completion];
    [self setFailureBlock:failure];
    [self startAsynchronous];
}

- (id)getObjectFromResponse{
    id object = nil;
    @try {
        object = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableContainers error:nil];

    } @catch (NSException *exception) {
        
    }
    return object;
}


- (id)getErrorFromResponse{
    return nil;
}
@end
