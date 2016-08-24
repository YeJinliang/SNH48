//
//  ThreeViewController.h
//  SNH48
//
//  Created by 夜锦凉 on 16/8/24.
//  Copyright © 2016年 夜锦凉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThreeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *message;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *load;
@property (weak, nonatomic) IBOutlet UIButton *start;
@property (weak, nonatomic) IBOutlet UIButton *stop;

- (IBAction)quickBuy:(UIButton *)sender;
- (IBAction)stopBuy:(UIButton *)sender;
- (IBAction)autoBuy:(UIButton *)sender;
@end
