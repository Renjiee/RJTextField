//
//  ViewController.m
//  RJTextField
//
//  Created by ChangRJey on 2017/7/27.
//  Copyright © 2017年 RenJiee. All rights reserved.
//

#import "ViewController.h"
#import "RJTextField.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RJTextField * account = [[RJTextField alloc]initWithFrame:CGRectMake(0, 60, SCREEN_SIZE.width, 60)];
    account.placeholder = @"请输入手机号";
    account.maxLength = 11;
    account.errorStr = @"超出字数限制";
    account.leftIconName = @"loginPhone";
    account.textField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:account];
    
    RJTextField * password = [[RJTextField alloc]initWithFrame:CGRectMake(0, 120, SCREEN_SIZE.width, 60)];
    password.placeholder = @"请输入密码";
    password.maxLength = 16;
    password.errorStr = @"超出字数限制";
    password.leftIconName = @"Key";
    password.textField.keyboardType = UIKeyboardTypeASCIICapable;
    password.textField.secureTextEntry = YES;
    [self.view addSubview:password];
    
}

// 退出键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
