//
//  XUEcation.h
//  blockDemo
//
//  Created by 徐继垚 on 15/9/15.
//  Copyright (c) 2015年 徐继垚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol XUExcationDeldgate <NSObject>

- (void)xuViewDidSeletView:(UIView *)view;

@end
@interface XUEcation : NSObject <XUExcationDeldgate>

@end
