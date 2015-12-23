//
//  ZTQueueNetworkWrapper.m
//  Pods
//
//  Created by 马成林 on 15/12/16.
//
//



#import "ZTQueueNetworkWrapper.h"

static dispatch_group_t zt_completion_group() {
    static dispatch_group_t zt_completion_group;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        zt_completion_group = dispatch_group_create();
    });
    
    return zt_completion_group;
}

@implementation ZTQueueNetworkWrapper


- (void)queue{
    NSURLSession * session = [NSURLSession sharedSession];
    
    NSURL *url = [NSURL URLWithString:@"http://"];
    
    dispatch_group_enter(zt_completion_group());
    
    NSURLSessionDataTask * dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        /* Do your stuff here */
        
        //Leave the group manually -> Value = Value - 1
        dispatch_group_leave(zt_completion_group());
    }];
    
    [dataTask resume];
    
    // Wait for the group's value to equals 0
    dispatch_group_wait(zt_completion_group(), DISPATCH_TIME_FOREVER);
}
@end
