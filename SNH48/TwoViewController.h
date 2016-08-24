//
//  TwoViewController.h
//  SNH48
//
//  Created by 夜锦凉 on 16/8/24.
//  Copyright © 2016年 夜锦凉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *loginid;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *codeText;
@property (weak, nonatomic) IBOutlet UIImageView *authcode;
@property (weak, nonatomic) IBOutlet UIButton *login;
- (IBAction)clickLogin:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *message;
@property (weak, nonatomic) IBOutlet UITextField *piaoID;
@property (weak, nonatomic) IBOutlet UITextField *erpiaoID;
@property (weak, nonatomic) IBOutlet UITextField *sanpiaoID;
- (IBAction)clickBuy:(id)sender;
@end
