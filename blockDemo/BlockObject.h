//
//  BlockObject.h
//  blockDemo
//
//  Created by 徐继垚 on 15/8/12.
//  Copyright (c) 2015年 徐继垚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlockObject : NSObject

- (void)getObjWithBlock:(void (^)(NSString * str))block;
@end
