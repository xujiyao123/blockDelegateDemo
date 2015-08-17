//
//  ViewController.m
//  blockDemo
//
//  Created by 徐继垚 on 15/8/12.
//  Copyright (c) 2015年 徐继垚. All rights reserved.
//

#import "ViewController.h"
#import "BlockObject.h"
#import "PushViewController.h"
#import "XUConstView.h"

@interface ViewController ()<XUConstViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.view.backgroundColor = [UIColor whiteColor];
    ///消息中心监听
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(relodadata:) name:@"reloda" object:nil];
    
    
    XUConstView * xuview = [[XUConstView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    xuview.delegate = self; //遵循代理
    xuview.title = @"注意看代理回调";
     [self.view addSubview:xuview];
    
    ///Block回调Action 若要使用  请把相对 代理方法注释
    
//    [xuview buttonDidSeletWithBlock:^(XUConstView *view) {
//           NSLog(@"%@" , view.title);
//        PushViewController * vc = [[PushViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }];
    ///11秒后执行
    [xuview viewToTimer:11 block:^(NSString *str) {
        ///这里和代理方法一样  可以写 在执行GCD 这11秒 时间里  需要做的东西
        NSLog(@"%@" , str);
    }];
    
    
   
    
    
    
    
    
    ///使用block从model类回调数据
    BlockObject * objc = [[BlockObject alloc]init];
    [objc getObjWithBlock:^(NSString *str) {
        NSLog(@"%@" , str);
        
    }];
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark - 自定义View代理方法
/// 用代理传过来的 buttonAction
- (void)xuViewDidSeletView:(XUConstView *)view
{
   ///传过来对应的 自定义view
    NSLog(@"%@" , view.title);
    
    ///这里面写 你在buttionAction 应该干的事
    PushViewController * vc = [[PushViewController alloc]init];
    ///此block 回调的是一个 状态值  , 当从的二个页面返回第一个页面是 要干什  比如说 刷新数据 或者其他
    [vc getObjWithBlock:^() {
        NSLog(@"__block --------页面pop回来了  我可以在这个转态 做什么");
        
    } ];
    [self.navigationController pushViewController:vc animated:YES];
}

#warning 重要 !!! : 一般情况下  代理方法 和 普通方法是反的   普通方法 的返回值  是代理方法要传进去的参数  普通方法的参数 是代理方法回调给你的 返回值!
- (void)timerBegion:(NSTimer *)timer Count:(NSInteger)count
{
      ///定时器正在计时  要干的事情  和返回的  秒数 以及定时器对象
    NSLog(@"%lu" , count);
}
-(NSInteger)timeEnd:(NSTimer *)timer
{
    ///想让定时器执行多少秒 就return 多少   类似 tableView  number of row 实现方法
    return 10;
}
- (void)timerDidEnd:(NSTimer *)timer endTime:(NSInteger)time
{
    ///定时器结束了  要干的事情  和返回的  秒数 以及定时器对象
    NSLog(@"timeEnd time : %lu" , time );
}
#pragma mark - 消息中心回调方法
- (void)relodadata:(NSNotification *)result
{
    NSLog(@"%@" , result.object);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
