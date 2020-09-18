//
//  UILabel+CLabel.m
//  CToolDemo
//
//  Created by sm on 2019/5/21.
//  Copyright © 2019 cyc. All rights reserved.
//

#import "UILabel+CLabel.h"

#define CLabelAction @"CLabelAction"

@implementation UILabel (CLabel)


- (void)addAction:(CLabelBlock)block {
    
    // 将block与self绑定
    objc_setAssociatedObject(self, CLabelAction, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelAction:)];
    [self addGestureRecognizer:tap];
    self.userInteractionEnabled = YES;
    
    
}

- (void)labelAction:(UITapGestureRecognizer *)tap {
    
    if (tap.state == UIGestureRecognizerStateEnded) {
        
        // 从绑定关系中获取block
        CLabelBlock block = objc_getAssociatedObject(self, CLabelAction);
        if (block) {
            block(tap.view.tag);
        }
        
    }
    
    
}


#pragma mark ========================================链式语法=============================================
CLabelSupporM(CGRect, frame)
CLabelSupporM(CGPoint, center)
CLabelSupporM(NSString *, text)
CLabelSupporM(UIColor *, textColor)
CLabelSupporM(UIColor *, backgroundColor)
CLabelSupporM(NSInteger, numberOfLines)
CLabelSupporM(NSAttributedString *, attributedText)
CLabelSupporM(UIFont *, font)
CLabelSupporM(NSTextAlignment, textAlignment)
CLabelSupporM(NSLineBreakMode, lineBreakMode)
CLabelSupporM(BOOL, adjustsFontSizeToFitWidth)







































@end
