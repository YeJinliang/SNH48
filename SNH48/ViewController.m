//
//  ViewController.m
//  SNH48
//
//  Created by 夜锦凉 on 16/8/23.
//  Copyright © 2016年 夜锦凉. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)click:(id)sender {
    
    AFHTTPSessionManager * manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://shop.48.cn"]];
    //请求类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"route=72b22cfe13b6559dd934c0716c55a35b; IESESSION=alive; pgv_pvi=6775823360; pgv_si=s767901696; .AspNet.ApplicationCookie=uDlnPeSRtvz_jkR_Yd54KIyLhAfAdYVBqxSKSwZh25iJW3Ev6xy0LrluVNmEoWIcgiIF7ZEO9PKg6AOdErKnVJM8ilcwEo6sZs5L4DZaGKOr5zZt3VgGum563S3XzSYERpnjW94SXYUUjKUYCOdEwFBJNLhlLnbGrX_aMzK9_ebZ-95UUL35SXHU_cqRlLWFGEs1KRTCQ86akRFp2020_d2HlCBumFg6PMUsIvXzg-TI_X73SI2EFec7rR0DR0IHLy1Ky6CdWnGVpDsJ1Kl2uFaMm-x5wYRrQ4U2UcGXN64OD4e4tbS7CSZKe1RrEvR7roPIms6qV3ju1RjEPNQPQH-IsSNvXRwckssk1gmlbGc6cCqQK0i8y-PgYTgplPTthPR6LRogN2OuHe_97sWOudCGmb_S8_3zfporJiIj6UVvirasQDB8euLFmz6b3BaFBW0YJi3Funi9CFrhhiUfruMio36ZFaJGgpDcXg73IwHPhvh_EpQXwGgDWmcFTz7Cy54czebPvBFPf6zTqGkI52WnlP84TQbED89qNrQzVGR5t3t7T9t9p2EViKBEzjR44kPw6EqwoKs6dwtsc8RisOkdzrmz67F9WX2xJRYJ6N-obvQ7ksQNigUYmGL6jA1u; uchome_auth=d4296b7ZPGJFRaEAi9A8%2FBCrCwvTKyF%2FX1OyWSCZ0iIrCMe%2BjNynXx%2F6HFfySq2eIc19CtjoATurUPUNKjm2feqhC%2B8; uchome_loginuser=%E9%A9%AC%E6%96%AF%E5%85%8B%E7%89%B9; __RequestVerificationToken=Y25FsFc3gHoHvRdlaEg04OydHpybLwPGG6cu5KhGeLVbThu8xLBpEImtsfFbSCtu90EV3HDP9xc6wemkzLDOD4jK391fGhfzKNxs7X3Midg1; tencentSig=2396268544; _qddamta_4006176598=3-0; _qdda=3-1.2dkq5o; _qddab=3-f4esk2.is7a6acx" forHTTPHeaderField:@"Cookie"];
    NSString * pid;
    if (self.piaoID.text.length) {
        pid = self.piaoID.text;
    }
    else {
        self.code.text = @"输入票id";
        return;
    }
    NSDictionary * dic = @{@"id":pid,@"num":@"1",@"seattype":@"3",@"brand_id":@"2",@"r":@"0.6302288675552128"};
    [manager POST:@"/TOrder/add" parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[NSData class]]) {
            responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        }
        NSLog(@"%@",responseObject);
        self.code.text = responseObject[@"Message"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];

}


@end
