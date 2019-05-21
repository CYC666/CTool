//
//  UIImageView+CImageView.m
//  CToolDemo
//
//  Created by sm on 2019/5/21.
//  Copyright © 2019 cyc. All rights reserved.
//

#import "UIImageView+CImageView.h"

#define CImageViewAction @"CImageViewAction"

@implementation UIImageView (CImageView)

- (void)addAction:(CToolBlock)block {
    
    // 将block与self绑定
    objc_setAssociatedObject(self, CImageViewAction, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewAction:)];
    [self addGestureRecognizer:tap];
    self.userInteractionEnabled = YES;
    
    
}

- (void)imageViewAction:(UITapGestureRecognizer *)tap {
    
    if (tap.state == UIGestureRecognizerStateEnded) {

        // 从绑定关系中获取block
        CToolBlock block = objc_getAssociatedObject(self, CImageViewAction);
        if (block) {
            block(@(tap.view.tag));
        }
    }
    
}



@end
