//
//  ViewController.m
//  ZTNetworkDemo
//
//  Created by mapengzhen on 15/12/14.
//  Copyright © 2015年 mapengzhen. All rights reserved.
//

#import "ViewController.h"
#import "ZTService.h"
#define token @"a8b43edbih7chddd48qqmfawq98ae5C1"
#define userid @"464"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *url = @"http://client.weimai.com/weimai/s/shop/bigitems.json";
    ZTService *service = [[ZTService alloc] init];
    
    for (int i=0; i<3; i++) {
        NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:@{@"id":userid,@"pageno":[NSString stringWithFormat:@"%d",i],@"token":token}];
        [service sendRequestWithUrlString:url requestMethod:ZT_REQUEST_METHOD_GET parameters:param completion:^(NSURLSessionDataTask * _Nullable response, id  _Nullable responseObject, NSError * _Nullable error) {
            NSLog(@"complete--%@",[NSDate date]);
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
