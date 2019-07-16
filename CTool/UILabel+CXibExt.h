//
//  UILabel+CXibExt.h
//  CToolDemo
//
//  Created by sm on 2019/7/16.
//  Copyright © 2019 cyc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 方便设置label的颜色


@interface UILabel (CXibExt)


@property (assign, nonatomic) IBInspectable BOOL Color333;    // 0x333333
@property (assign, nonatomic) IBInspectable BOOL Color666;    // 0x666666
@property (assign, nonatomic) IBInspectable BOOL Color999;    // 0x999999



@end

NS_ASSUME_NONNULL_END
