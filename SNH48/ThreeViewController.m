//
//  ThreeViewController.m
//  SNH48
//
//  Created by 夜锦凉 on 16/8/24.
//  Copyright © 2016年 夜锦凉. All rights reserved.
//

#import "ThreeViewController.h"
#import "AFNetworking.h"

@interface ThreeViewController ()

@property (nonatomic ,strong) NSTimer * timer;

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    self.stop.enabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)quickBuy:(UIButton *)sender {
    sender.enabled = NO;
    self.stop.enabled = YES;
    [self.load startAnimating];
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(startBuy) userInfo:nil repeats:YES];
}

- (IBAction)stopBuy:(UIButton *)sender {
    sender.enabled = NO;
    self.start.enabled = YES;
    [self.load stopAnimating];
    [_timer invalidate];
}

- (IBAction)autoBuy:(UIButton *)sender {
    [self buyTicket:@"353"];
    [self buyTicket:@"354"];
    [self buyTicket:@"355"];
}

- (void)startBuy{
    [self buyTicket:@"353"];
    [self buyTicket:@"354"];
    [self buyTicket:@"355"];
    NSLog(@"%@",[NSDate date]);
}

- (void)buyTicket:(NSString *) pid{
    AFHTTPSessionManager * manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://shop.48.cn"]];
    //请求类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"route=72b22cfe13b6559dd934c0716c55a35b; IESESSION=alive; pgv_pvi=6775823360; pgv_si=s767901696; .AspNet.ApplicationCookie=uDlnPeSRtvz_jkR_Yd54KIyLhAfAdYVBqxSKSwZh25iJW3Ev6xy0LrluVNmEoWIcgiIF7ZEO9PKg6AOdErKnVJM8ilcwEo6sZs5L4DZaGKOr5zZt3VgGum563S3XzSYERpnjW94SXYUUjKUYCOdEwFBJNLhlLnbGrX_aMzK9_ebZ-95UUL35SXHU_cqRlLWFGEs1KRTCQ86akRFp2020_d2HlCBumFg6PMUsIvXzg-TI_X73SI2EFec7rR0DR0IHLy1Ky6CdWnGVpDsJ1Kl2uFaMm-x5wYRrQ4U2UcGXN64OD4e4tbS7CSZKe1RrEvR7roPIms6qV3ju1RjEPNQPQH-IsSNvXRwckssk1gmlbGc6cCqQK0i8y-PgYTgplPTthPR6LRogN2OuHe_97sWOudCGmb_S8_3zfporJiIj6UVvirasQDB8euLFmz6b3BaFBW0YJi3Funi9CFrhhiUfruMio36ZFaJGgpDcXg73IwHPhvh_EpQXwGgDWmcFTz7Cy54czebPvBFPf6zTqGkI52WnlP84TQbED89qNrQzVGR5t3t7T9t9p2EViKBEzjR44kPw6EqwoKs6dwtsc8RisOkdzrmz67F9WX2xJRYJ6N-obvQ7ksQNigUYmGL6jA1u; uchome_auth=d4296b7ZPGJFRaEAi9A8%2FBCrCwvTKyF%2FX1OyWSCZ0iIrCMe%2BjNynXx%2F6HFfySq2eIc19CtjoATurUPUNKjm2feqhC%2B8; uchome_loginuser=%E9%A9%AC%E6%96%AF%E5%85%8B%E7%89%B9; __RequestVerificationToken=Y25FsFc3gHoHvRdlaEg04OydHpybLwPGG6cu5KhGeLVbThu8xLBpEImtsfFbSCtu90EV3HDP9xc6wemkzLDOD4jK391fGhfzKNxs7X3Midg1; tencentSig=2396268544; _qddamta_4006176598=3-0; _qdda=3-1.2dkq5o; _qddab=3-f4esk2.is7a6acx" forHTTPHeaderField:@"Cookie"];
    NSDictionary * dic = @{@"id":pid,@"num":@"1",@"seattype":@"2",@"brand_id":@"3",@"r":@"0.6302288675552128"};
    [manager POST:@"/TOrder/add" parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[NSData class]]) {
            responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        }
        NSLog(@"%@",responseObject);
        if (self.message.text.length > 300) {
            self.message.text = @"";
        }
        self.message.text = [NSString stringWithFormat:@"%@%@-%@",self.message.text,pid,responseObject[@"Message"]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];

}
@end
