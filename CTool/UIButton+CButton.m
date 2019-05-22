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





@end
