//
//  ZTNetworkExceptionObserver.m
//  ZTNetworkDemo
//
//  Created by natural on 16/9/10.
//  Copyright © 2016年 mapengzhen. All rights reserved.
//

#import "ZTNetworkExceptionMonitor.h"
#import "ZTCommonFunction.h"

@implementation ZTNetworkExceptionMonitor

- (void)addObserver:(id)observer forException:(NSString *)exceptionName withSelector:(SEL)selector{
    ZTAddObserver(observer, selector, exceptionName, nil);
}


@end
