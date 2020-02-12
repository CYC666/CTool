//
//  UIView+CAction.m
//  CToolDemo
//
//  Created by 曹老师 on 2020/2/12.
//  Copyright © 2020 cyc. All rights reserved.
//

#import "UIView+CAction.h"


#define CViewAction @"CViewAction"

@implementation UIView (CView)


- (void)addAction:(CViewBlock)block {
    
    // 将block与self绑定
    objc_setAssociatedObject(self, CViewAction, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelAction:)];
    [self addGestureRecognizer:tap];
    self.userInteractionEnabled = YES;
    
    
}

- (void)labelAction:(UITapGestureRecognizer *)tap {
    
    if (tap.state == UIGestureRecognizerStateEnded) {
        
        // 从绑定关系中获取block
        CViewBlock block = objc_getAssociatedObject(self, CViewAction);
        if (block) {
            block(tap.view.tag);
        }
        
    }
    
    
    
    
}
@end
