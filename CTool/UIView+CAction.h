//
//  UIView+CAction.h
//  CToolDemo
//
//  Created by 曹老师 on 2020/2/12.
//  Copyright © 2020 cyc. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "CTool.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CViewBlock)(NSInteger tag);


@interface UIView (CAction)

- (void)addAction:(CViewBlock)block;

@end

NS_ASSUME_NONNULL_END
