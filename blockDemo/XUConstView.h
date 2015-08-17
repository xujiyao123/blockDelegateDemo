//
//  XUConstView.h
//  blockDemo
//
//  Created by 徐继垚 on 15/8/14.
//  Copyright (c) 2015年 徐继垚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@protocol XUConstViewDelegate;
@interface XUConstView : UIView

///此自定义view主要演示怎么回调buttonAction 使用代理 以及block
@property (nonatomic ,retain)NSString * title;

///定义代理属性
@property (nonatomic ,assign)id <XUConstViewDelegate> delegate;

///使用Block传递buttonAction
- (void)buttonDidSeletWithBlock:(void(^)(XUConstView *view))block;

///模拟gcd 使用假数据
- (void)viewToTimer:(NSTimeInterval)time block:(void(^)(NSString *str))block;
@end

///声明代理
@protocol XUConstViewDelegate <NSObject>
///可选方法 不不要执行
@optional
///回调点击action 传出自定义view;
- (void)xuViewDidSeletView:(XUConstView *)view;

///定时器启动时需要干什么 回调timer对象  以及count
- (void)timerBegion:(NSTimer *)timer Count:(NSInteger)count;

///给定时器设定定时时间
- (NSInteger)timeEnd:(NSTimer *)timer;

///定时结束 回调状态
- (void)timerDidEnd:(NSTimer *)timer endTime:(NSInteger)time;

@end