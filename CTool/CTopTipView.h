//
//  CTopTipView.h
//  CToolDemo
//
//  Created by sm on 2019/5/22.
//  Copyright © 2019 cyc. All rights reserved.
//


// 一个类似于在屏幕顶部弹出的远程通知视图

#import <UIKit/UIKit.h>
#import "CTool.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTopTipView : UIView




+ (void)setTextColor:(UIColor *)color;          // 文本颜色
+ (void)setTextFont:(UIFont *)font;             // 文本字体
+ (void)setBackgroupColor:(UIColor *)color;     // 背景颜色
+ (void)setObDistance:(float)distance;          // 左右边距
+ (void)setDisplayTime:(float)time;             // 显示时长
+ (void)setAnimationTime:(float)time;           // 动画时长

+ (void)showWithText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
