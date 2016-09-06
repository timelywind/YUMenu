//
//  ViewController.m
//  YUMenu
//
//  Created by administrator on 16/9/6.
//  Copyright © 2016年 xuanYuLin. All rights reserved.
//

#import "ViewController.h"
#import "YUMenuOne.h"
#import "YUMenuTwo.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 创建menuOne
    YUMenuOne *menuOne = [[YUMenuOne alloc] initWithFrame:CGRectMake(300, 100, 50, 50)];
    [self.view addSubview:menuOne];
    
    // 创建menuTwo
    YUMenuTwo *menuTwo = [[YUMenuTwo alloc]initWithFrame:CGRectMake(100, 100, 50, 50)];
    [self.view addSubview:menuTwo];
    // 添加按钮
    NSMutableArray *arrayM = [NSMutableArray array];
    for (int i = 0; i< 8; i++) {
        UIButton *btn = [UIButton new];
        NSString *name = [NSString stringWithFormat:@"found_icons_%d",i];
        [btn setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
        [arrayM addObject:btn];
    }
    menuTwo.btns = arrayM;
    
    
}

@end
