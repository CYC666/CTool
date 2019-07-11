//
//  UIView+CXibExt.m
//  CToolDemo
//
//  Created by sm on 2019/7/11.
//  Copyright © 2019 cyc. All rights reserved.
//

#import "UIView+CXibExt.h"

@implementation UIView (CXibExt)



// 描边
- (void)setCBoderWidth:(CGFloat)cBoderWidth {
    self.layer.borderWidth = cBoderWidth;
}
- (CGFloat)cBoderWidth {
    return self.layer.borderWidth;
}

- (void)setCBoderRadius:(CGFloat)cBoderRadius {
    self.layer.cornerRadius = cBoderRadius;
}
- (CGFloat)cBoderRadius {
    return self.layer.cornerRadius;
}

- (void)setCBoderColor:(UIColor *)cBoderColor {
    self.layer.borderColor = cBoderColor.CGColor;
}
- (UIColor *)cBoderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

// 阴影
- (void)setCShadowOffsetX:(CGFloat)cShadowOffsetX {
    self.layer.shadowOffset = CGSizeMake(cShadowOffsetX, self.layer.shadowOffset.height);
}
- (CGFloat)cShadowOffsetX {
    return self.layer.shadowOffset.width;
}

- (void)setCShadowOffsetY:(CGFloat)cShadowOffsetY {
    self.layer.shadowOffset = CGSizeMake(self.layer.shadowOffset.width, cShadowOffsetY);
}
- (CGFloat)cShadowOffsetY {
    return self.layer.shadowOffset.height;
}

- (void)setCShadowRadius:(CGFloat)cShadowRadius {
    self.layer.shadowRadius = cShadowRadius;
}
- (CGFloat)cShadowRadius {
    return self.layer.shadowRadius;
}

- (void)setCShadowOpacity:(CGFloat)cShadowOpacity {
    self.layer.shadowOpacity = cShadowOpacity;
}
- (CGFloat)cShadowOpacity {
    return self.layer.shadowOpacity;
}

- (void)setCShadowColor:(UIColor *)cShadowColor {
    self.layer.shadowColor = cShadowColor.CGColor;
}
- (UIColor *)cShadowColor {
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}


















@end
