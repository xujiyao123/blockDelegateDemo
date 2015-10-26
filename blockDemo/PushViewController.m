//
//  PushViewController.m
//  blockDemo
//
//  Created by 徐继垚 on 15/8/13.
//  Copyright (c) 2015年 徐继垚. All rights reserved.
//

#import "PushViewController.h"

@interface PushViewController ()

@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    UIButton * backbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backbutton setTitle:@"back" forState:UIControlStateNormal];
    backbutton.frame = CGRectMake(0, 0, 100, 30);
    [backbutton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backbutton];

    
    UILabel * label = [[UILabel alloc]initWithFrame:[UIScreen mainScreen].bounds];
    label.text = @"这是一个 delegate, block ,深层应用的demo , 希望对你有帮助 , 注释详细 ,请仔细阅读 , 查看其他 demo ,请在github中 搜索用户 xujiyao123 ,谢谢对我的认可和支持, 谢谢!";
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
    
    // Do any additional setup after loading the view.
}
- (void)backAction:(id)sender
{
    ///要回调什么转态  请在状态中使用block
    if (self.block) {
        
        self.block();
        
    
    }
    
    
    ///下面是消息中心进行回调
    [[NSNotificationCenter defaultCenter]postNotificationName:@"reloda" object:@"__notfication --------页面pop回来了  我可以在这个转态 做什么"];
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)getObjWithBlock:(myblock)block
{
    if (block) {
        self.block = block;
    }
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

@end
