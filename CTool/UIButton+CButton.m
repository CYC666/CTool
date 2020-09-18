//
//  UIButton+CButton.m
//  CToolDemo
//
//  Created by sm on 2019/5/21.
//  Copyright © 2019 cyc. All rights reserved.
//

#import "UIButton+CButton.h"

#define CButtonAction @"CButtonAction"

@implementation UIButton (CButton)


- (void)addAction:(CButtonBlock)block {
    
    // 将block与self绑定
    objc_setAssociatedObject(self, CButtonAction, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)buttonAction:(UIButton *)button {
    
    CButtonBlock block = objc_getAssociatedObject(self, CButtonAction);
    if (block) {
        block(button.tag);
    }
    
}

#pragma mark ========================================链式语法=============================================

CButtonSupporM(CGRect, frame)
CButtonSupporM(CGPoint, center)

- (UIButton * _Nonnull (^)(UIControlContentHorizontalAlignment))hAlignmentSet {
    return ^(UIControlContentHorizontalAlignment align) {
        self.contentHorizontalAlignment = align;
        return self;
    };
}

- (UIButton * _Nonnull (^)(UIControlContentVerticalAlignment))vAlignmentSet {
    return ^(UIControlContentVerticalAlignment align) {
        self.contentVerticalAlignment = align;
        return self;
    };
}

- (UIButton * _Nonnull (^)(NSString * _Nonnull))titleSet {
    return ^(NSString *title) {
        
        [self setTitle:title forState:UIControlStateNormal];
        return self;
    };
}

- (UIButton * _Nonnull (^)(UIColor * _Nonnull))colorSet {
    return ^(UIColor *color) {
        [self setTitleColor:color forState:UIControlStateNormal];
        return self;
    };
}

- (UIButton * _Nonnull (^)(UIColor * _Nonnull))bgColorSet {
    return ^(UIColor *color) {
        self.backgroundColor = color;
        return self;
    };
}

- (UIButton * _Nonnull (^)(UIFont * _Nonnull))fontSet {
    return ^(UIFont *font) {
        self.titleLabel.font = font;
        return self;
    };
}

- (UIButton * _Nonnull (^)(UIImage * _Nonnull))imageSet {
    return ^(UIImage *image) {
        [self setImage:image forState:UIControlStateNormal];
        return self;
    };
}





































@end
