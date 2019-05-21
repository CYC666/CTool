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


- (void)addAction:(CToolBlock)block {
    
    // 将block与self绑定
    objc_setAssociatedObject(self, CLabelAction, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelAction:)];
    [self addGestureRecognizer:tap];
    self.userInteractionEnabled = YES;
    
    
}

- (void)labelAction:(UITapGestureRecognizer *)tap {
    
    if (tap.state == UIGestureRecognizerStateEnded) {
        
        // 从绑定关系中获取block
        CToolBlock block = objc_getAssociatedObject(self, CLabelAction);
        if (block) {
            block(@(tap.view.tag));
        }
        
    }
    
    
    
    
}


@end