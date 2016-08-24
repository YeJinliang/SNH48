//
//  ViewController.h
//  SNH48
//
//  Created by 夜锦凉 on 16/8/23.
//  Copyright © 2016年 夜锦凉. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AFNetworking.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *piaoID;
@property (weak, nonatomic) IBOutlet UILabel *code;
- (IBAction)click:(id)sender;

@end

