//
//  UIView+cFrame.h
//  CToolDemo
//
//  Created by 曹老师 on 2020/2/8.
//  Copyright © 2020 cyc. All rights reserved.
//




#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (cFrame)

@property (nonatomic, assign) CGPoint c_origin;
@property (nonatomic, assign) CGSize c_size;

@property (nonatomic) CGFloat c_centerX;
@property (nonatomic) CGFloat c_centerY;


@property (nonatomic) CGFloat c_top;
@property (nonatomic) CGFloat c_bottom;
@property (nonatomic) CGFloat c_right;
@property (nonatomic) CGFloat c_left;

@property (nonatomic) CGFloat c_width;
@property (nonatomic) CGFloat c_height;



@end

NS_ASSUME_NONNULL_END
