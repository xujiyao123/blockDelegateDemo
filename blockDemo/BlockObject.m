//
//  BlockObject.m
//  blockDemo
//
//  Created by 徐继垚 on 15/8/12.
//  Copyright (c) 2015年 徐继垚. All rights reserved.
//

#import "BlockObject.h"

@implementation BlockObject
- (void)getObjWithBlock:(void (^)(NSString *))block
{
    NSString * aa = @"回调";
    if (block) {
        block(aa);
    }
    
}
@end
