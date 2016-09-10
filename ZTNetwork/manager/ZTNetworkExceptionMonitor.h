//
//  ZTNetworkExceptionObserver.h
//  ZTNetworkDemo
//
//  Created by natural on 16/9/10.
//  Copyright © 2016年 mapengzhen. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * 监听到网络异常，发送通知，ZTNetworkExceptionObserver处理异常
 */
@interface ZTNetworkExceptionMonitor : NSObject

- (void)addObserver:(id)observer forException:(NSString *)exceptionName withSelector:(SEL)selector;

@end
