//
//  PushViewController.h
//  blockDemo
//
//  Created by 徐继垚 on 15/8/13.
//  Copyright (c) 2015年 徐继垚. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^myblock)();

@interface PushViewController : UIViewController
@property (nonatomic ,copy)myblock block;

/// block 不仅仅用来传值  ,使用更多的是传递一个状态, 或监听状态
- (void)getObjWithBlock:(myblock)block;
@end
