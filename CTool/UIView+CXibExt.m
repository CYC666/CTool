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
- (void)setCB_Width:(CGFloat)cB_Width {
    self.layer.borderWidth = cB_Width;
}
- (CGFloat)cB_Width {
    return self.layer.borderWidth;
}

- (void)setCB_Radius:(CGFloat)cB_Radius {
    self.layer.cornerRadius = cB_Radius;
}
- (CGFloat)cB_Radius {
    return self.layer.cornerRadius;
}

- (void)setCB_Color:(UIColor *)cB_Color {
    self.layer.borderColor = cB_Color.CGColor;
}
- (UIColor *)cB_Color {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

// 阴影
- (void)setCS_OffsetX:(CGFloat)cS_OffsetX {
    self.layer.shadowOffset = CGSizeMake(cS_OffsetX, self.layer.shadowOffset.height);
}
- (CGFloat)cS_OffsetX {
    return self.layer.shadowOffset.width;
}

- (void)setCS_OffsetY:(CGFloat)cS_OffsetY {
    self.layer.shadowOffset = CGSizeMake(self.layer.shadowOffset.width, cS_OffsetY);
}
- (CGFloat)cS_OffsetY {
    return self.layer.shadowOffset.height;
}

- (void)setCS_Radius:(CGFloat)cS_Radius {
    self.layer.shadowRadius = cS_Radius;
}
- (CGFloat)cS_Radius {
    return self.layer.shadowRadius;
}

- (void)setCS_Opacity:(CGFloat)cS_Opacity {
    self.layer.shadowOpacity = cS_Opacity;
}
- (CGFloat)cS_Opacity {
    return self.layer.shadowOpacity;
}

- (void)setCS_Color:(UIColor *)cS_Color {
    self.layer.shadowColor = cS_Color.CGColor;
}
- (UIColor *)cS_Color {
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}


















@end
