//
//  TwoViewController.m
//  SNH48
//
//  Created by 夜锦凉 on 16/8/24.
//  Copyright © 2016年 夜锦凉. All rights reserved.
//

#import "TwoViewController.h"

#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"


static NSString * route = @"72b22cfe13b6559dd934c0716c55a35b";
static NSString * iesession = @"alive";
static NSString * pgv_pvi = @"6775823360";
static NSString * pgv_si = @"s767901696";
static NSString * __RequestVerificationToken = @"Y25FsFc3gHoHvRdlaEg04OydHpybLwPGG6cu5KhGeLVbThu8xLBpEImtsfFbSCtu90EV3HDP9xc6wemkzLDOD4jK391fGhfzKNxs7X3Midg1";
static NSString * tencentSig = @"2396268544";

@interface TwoViewController ()

@property (nonatomic ,strong) NSMutableDictionary * otherCookieDic;
@property (nonatomic ,copy) NSString * seattype;

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _otherCookieDic = [NSMutableDictionary new];
    self.seattype = @"2";
    
    NSURL * url = [NSURL URLWithString:@"http://user.snh48.com/authcode/code.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    [request addValue:@"Hm_lvt_9f84effb6c7767ef67ebacccad4a2279=1471942542; Hm_lpvt_9f84effb6c7767ef67ebacccad4a2279=1471942688; pgv_pvi=3676520760; pgv_info=ssi=s7574338445; PHPSESSID=08254c8cc7ce45990e11d7bf97c684bb" forHTTPHeaderField:@"Cookie"];
    [self.authcode setImageWithURLRequest:request placeholderImage:nil success:nil failure:nil];
}

- (IBAction)clickLogin:(id)sender {
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    //请求类型
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"Hm_lvt_9f84effb6c7767ef67ebacccad4a2279=1471942542; Hm_lpvt_9f84effb6c7767ef67ebacccad4a2279=1471942688; pgv_pvi=3676520760; pgv_info=ssi=s7574338445; PHPSESSID=08254c8cc7ce45990e11d7bf97c684bb" forHTTPHeaderField:@"Cookie"];
    
    NSDictionary * dic = @{@"username":self.loginid.text,@"password":self.password.text,@"code":self.codeText.text,@"submit":@"adadadad",@"return_url":@"http://shop.48.cn/tickets/item/338",@"submit":@"立即登录"};
    [manager POST:@"http://user.snh48.com/code/login_nodb.php" parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        //        NSLog(@"%@",responseObject);
        NSData * data = responseObject;
        NSString * dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //        NSLog(@"%@",dataString);
        self.message.text = @"登录成功";
        NSArray * htmlArr = [dataString componentsSeparatedByString:@"\""];
        for (NSString * string in htmlArr) {
            if ([string hasPrefix:@"http://www.48.cn"]) {
                NSLog(@"%@",string);
                [self getWWWCookies:string];
            }
            else if ([string hasPrefix:@"http://shop.48.cn"]) {
                NSLog(@"%@",string);
                [self getCookies:string];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
}

- (IBAction)clickBuy:(id)sender {
    if (self.piaoID.text.length) {
        NSString * pid = self.piaoID.text;
        [self buyWithID:pid];
    }
    
    if (self.erpiaoID.text.length) {
        NSString * pid = self.erpiaoID.text;
        [self buyWithID:pid];
    }
    
    if (self.sanpiaoID.text.length) {
        NSString * pid = self.sanpiaoID.text;
        [self buyWithID:pid];
    }
    
    if (self.piaoID.text.length == 0 && self.erpiaoID.text.length == 0 && self.sanpiaoID.text.length == 0) {
        self.message.text = @"输入票id";
    }
}

- (IBAction)changeType:(UISegmentedControl *)sender {
    self.seattype = [NSString stringWithFormat:@"%ld",sender.selectedSegmentIndex + 2];
    
}
- (void)buyWithID:(NSString *)pid{
    AFHTTPSessionManager * manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://shop.48.cn"]];
    //请求类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableString * userCookies = [NSMutableString new];
    NSArray * nameArr = self.otherCookieDic.allKeys;
    for (int i = 0; i < nameArr.count; i++) {
        NSString * name = nameArr[i];
        NSString * cookValue = self.otherCookieDic[name];
        [userCookies appendFormat:@"%@=%@; ",name,cookValue];
    }
    NSString * newCookies = [NSString stringWithFormat:@"%@route=%@; IESESSION=%@; pgv_pvi=%@; pgv_si=%@; __RequestVerificationToken=%@; tencentSig=%@; _qddamta_4006176598=3-0; _qdda=3-1.2dkq5o; _qddab=3-f4esk2.is7a6acx",userCookies,route,iesession,pgv_pvi,pgv_si,__RequestVerificationToken,tencentSig];
    [manager.requestSerializer setValue:newCookies forHTTPHeaderField:@"Cookie"];
    
    NSDictionary * dic = @{@"id":pid,@"num":@"1",@"seattype":self.seattype,@"brand_id":@"2",@"r":@"0.6302288675552128"};
    [manager POST:@"/TOrder/add" parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[NSData class]]) {
            responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        }
        NSLog(@"%@",responseObject);
        if (self.message.text.length > 100) {
            self.message.text = @"";
        }
        self.message.text = [NSString stringWithFormat:@"%@%@-%@",self.message.text,pid,responseObject[@"Message"]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];

}

- (void)getCookies:(NSString *)shopUrl{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer new];
    
    NSString * newcookie = [NSString stringWithFormat:@"route=%@; IESESSION=%@; pgv_pvi=%@; pgv_si=%@; __RequestVerificationToken=%@; tencentSig=%@; SessionID=yc5nhxhkp3mzepurpzica21i; _qddamta_4006176598=3-0; uchome_loginuser=%@; _qdda=3-1.2dkq5o; _qddab=3-244zzh.is8dhwce",route,iesession,pgv_pvi,pgv_si,__RequestVerificationToken,tencentSig,self.loginid.text];
    [manager.requestSerializer setValue:newcookie forHTTPHeaderField:@"Cookie"];
    [manager GET:shopUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //获取cookie
        NSArray * cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
        //把cookie进行归档并转换为NSData类型
        //        NSData * cookiesData = [NSKeyedArchiver archivedDataWithRootObject:cookies];
        for (NSHTTPCookie *tempCookie in cookies) {
            //打印获得的cookie
            //            NSLog(@"getCookie: %@", tempCookie);
            NSLog(@"%@-%@",tempCookie.name,tempCookie.value);
            [_otherCookieDic setObject:tempCookie.value forKey:tempCookie.name];
        }
        
        //存储归档后的cookie
        //        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        //        [userDefaults setObject: cookiesData forKey: @"cookie"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}
- (void)getWWWCookies:(NSString *)wwwUrl{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer new];
    
    NSString * newcookie = [NSString stringWithFormat:@"pgv_pvi=%@; pgv_si=%@; uchome_loginuser=%@",pgv_pvi,pgv_si,self.loginid.text];
    [manager.requestSerializer setValue:newcookie forHTTPHeaderField:@"Cookie"];
    [manager GET:wwwUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //获取cookie
        NSArray * cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
        //把cookie进行归档并转换为NSData类型
        //        NSData * cookiesData = [NSKeyedArchiver archivedDataWithRootObject:cookies];
        for (NSHTTPCookie *tempCookie in cookies) {
            //打印获得的cookie
            //            NSLog(@"getCookie: %@", tempCookie);
            NSLog(@"%@-%@",tempCookie.name,tempCookie.value);
            [_otherCookieDic setObject:tempCookie.value forKey:tempCookie.name];
        }
        
        //存储归档后的cookie
        //        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        //        [userDefaults setObject: cookiesData forKey: @"cookie"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}


@end
