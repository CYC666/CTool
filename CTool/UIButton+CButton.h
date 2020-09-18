//
//  UIButton+CButton.h
//  CToolDemo
//
//  Created by sm on 2019/5/21.
//  Copyright © 2019 cyc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTool.h"

// 链式语法支持
#define CButtonSupporH(propertyModifier, propertyPointerType, propertyName)           \
@property(nonatomic,propertyModifier)propertyPointerType  propertyName;                                                 \
- (UIButton * (^) (propertyPointerType propertyName)) propertyName##Set;

#define CButtonSupporM(propertyPointerType, propertyName)                                       \
- (UIButton * (^) (propertyPointerType propertyName))propertyName##Set{                                                \
return ^(propertyPointerType propertyName) {                                                                            \
self.propertyName = propertyName;                                                                                       \
return self;                                                                                                            \
};                                                                                                                      \
}

NS_ASSUME_NONNULL_BEGIN

typedef void(^CButtonBlock)(NSInteger tag);

@interface UIButton (CButton)

CButtonSupporH(assign, CGRect, frame)
CButtonSupporH(assign, CGPoint, center)
CButtonSupporH(assign, UIControlContentHorizontalAlignment, hAlignment)
CButtonSupporH(assign, UIControlContentVerticalAlignment, vAlignment)
CButtonSupporH(copy, NSString *, title)
CButtonSupporH(strong, UIColor *, color)
CButtonSupporH(strong, UIColor *, bgColor)
CButtonSupporH(strong, UIFont *, font)
CButtonSupporH(strong, UIImage *, image)



// 添加响应
- (void)addAction:(CButtonBlock)block;

@end

NS_ASSUME_NONNULL_END
