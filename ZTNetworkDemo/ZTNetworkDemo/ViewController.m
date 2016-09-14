//
//  ViewController.m
//  ZTNetworkDemo
//
//  Created by mapengzhen on 15/12/14.
//  Copyright © 2015年 mapengzhen. All rights reserved.
//

#import "ViewController.h"
#define token @"a8b43edbih7chddd48qqmfawq98ae5C1"
#define userid @"464"
#import "ZTNetworkService.h"

@interface ViewController ()
@property (nonatomic, strong) ZTNetworkService *service;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *url = @"http://japi.juhe.cn/book/recommend.from";
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:@{@"key":@"0f39614d3ff370d9be6f3629d6f3c3c8",@"cat":[NSString stringWithFormat:@"%d",1],@"ranks":@"1"}];
    _service = [[ZTNetworkService alloc] init];
    __weak ViewController *instance = self;
    [_service sendRequestToUrl:[NSURL URLWithString:url] requestMethod:ZTNetworkRequestMethodGet parameters:param completion:^{
        NSLog(@"%@",[instance.service getObjectFromResponse]);

    } failure:^{
        NSLog(@"%@",instance.service.error);

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
