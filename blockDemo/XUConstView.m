//
//  XUConstView.m
//  blockDemo
//
//  Created by 徐继垚 on 15/8/14.
//  Copyright (c) 2015年 徐继垚. All rights reserved.
//

#import "XUConstView.h"
@interface XUConstView()
{
    int _i ;
}
@property (nonatomic ,retain)UIButton * button;

@property (nonatomic ,retain)NSTimer *timer;
@end
@implementation XUConstView
///定义一个静态key 关联时使用
static char ButtonSeletKey;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(100, 100, 100, 100);
    self.button.backgroundColor = [UIColor redColor];
    [self.button addTarget:self action:@selector(abuttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.button];
    /// 定义一个定时器 当时间走10的时候停止定时器 回调完毕状态
    _i = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(objcChange) userInfo:nil repeats:YES];
        
    }
    return self;
}
///模拟假数据变动  监听变动  回调数据
- (void)objcChange
{
    _i ++;
    ///实现代理
    [self.delegate timerBegion:self.timer Count:_i];
    
    ///判断传进来的时间  如果到了  就停止定时器
    if (_i == [self.delegate timeEnd:self.timer]) {
        ///停止定时器
        [self.timer invalidate];
        [self.delegate timerDidEnd:self.timer endTime:[self.delegate timeEnd:self.timer]];
    }
}
///实现block 回调方法
- (void)buttonDidSeletWithBlock:(void(^)(XUConstView *view))block
{
    ///为了避免重复添加target 回调之前 先移除target
    [self.button removeTarget:self action:@selector(abuttonAction:) forControlEvents:UIControlEventTouchUpInside];
    ///关联block 与 button
    objc_setAssociatedObject(self.button, &ButtonSeletKey, block, OBJC_ASSOCIATION_COPY);
    
    [self.button addTarget:self action:@selector(abuttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
///当自定义view 有button 你需呀使用时怎么 回调出去
- (void)abuttonAction:(UIButton *)sender
{
    ///判断代理 是否响应次方法  进行回调
//    if ([self.delegate respondsToSelector:@selector(xuViewDidSeletView:)]) {
//        ///实现代理 回调Action
//        [self.delegate performSelector:@selector(xuViewDidSeletView:) withObject:self];
//    }
    
    id delegate = [[XUEcation alloc]init];
    if ([delegate respondsToSelector:@selector(xuViewDidSeletView:)]) {
        
        [delegate xuViewDidSeletView:self];
    }
    
    
    ///判断是否 block响应
    if ([self respondsToSelector:@selector(buttonDidSeletWithBlock:)]){
        
        ///取出关联  开始回调
       ///定义block对象  接收关联
        typedef  void (^seletBlock)(XUConstView * view);
        seletBlock block = (seletBlock)objc_getAssociatedObject(sender, &ButtonSeletKey);
        ///回调
       if(block)
       {
           block(self);
       }
    }
    
}

///模拟第二种block回调方法
- (void)viewToTimer:(NSTimeInterval)time block:(void (^)(NSString *))block
{
    
    ///使用GCD  time秒   后执行
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)),
                 dispatch_get_main_queue(), ^{
      ///回调Gcd
        NSString * str = [NSString stringWithFormat:@"%f秒后执行了" , time];
        if (block) {
            block(str);
        }
    });
    
    
}

///重写title set get方法
- (void)setTitle:(NSString *)title
{
    [self.button setTitle:title forState:UIControlStateNormal];
}
-(NSString *)title
{
    return [self.button titleForState:UIControlStateNormal];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
