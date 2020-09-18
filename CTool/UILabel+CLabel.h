//
//  UILabel+CLabel.h
//  CToolDemo
//
//  Created by sm on 2019/5/21.
//  Copyright © 2019 cyc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTool.h"

// 链式语法支持
#define CLabelSupporH(propertyModifier, propertyPointerType, propertyName)           \
@property(nonatomic,propertyModifier)propertyPointerType  propertyName;                                                 \
- (UILabel * (^) (propertyPointerType propertyName)) propertyName##Set;

#define CLabelSupporM(propertyPointerType, propertyName)                                       \
- (UILabel * (^) (propertyPointerType propertyName))propertyName##Set{                                                \
return ^(propertyPointerType propertyName) {                                                                            \
self.propertyName = propertyName;                                                                                       \
return self;                                                                                                            \
};                                                                                                                      \
}


NS_ASSUME_NONNULL_BEGIN

typedef void(^CLabelBlock)(NSInteger tag);

@interface UILabel (CLabel)


CLabelSupporH(assign, CGRect, frame)
CLabelSupporH(assign, CGPoint, center)
CLabelSupporH(copy, NSString *, text)
CLabelSupporH(strong, UIColor *, textColor)
CLabelSupporH(strong, UIColor *, backgroundColor)
CLabelSupporH(assign, NSInteger, numberOfLines)
CLabelSupporH(strong, NSAttributedString *, attributedText)
CLabelSupporH(strong, UIFont *, font)
CLabelSupporH(assign, NSTextAlignment, textAlignment)
CLabelSupporH(assign, NSLineBreakMode, lineBreakMode)
CLabelSupporH(assign, BOOL, adjustsFontSizeToFitWidth)

- (void)addAction:(CLabelBlock)block;





@end

NS_ASSUME_NONNULL_END
