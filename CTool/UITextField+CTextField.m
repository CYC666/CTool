//
//  UITextField+CTextField.m
//  CToolDemo
//
//  Created by sm on 2019/5/21.
//  Copyright © 2019 cyc. All rights reserved.
//

#import "UITextField+CTextField.h"

#define CTextFieldAction @"CTextFieldAction"

@implementation UITextField (CTextField)

- (void)addAction:(CTextFieldBlock)block {

    // 将block与self绑定，绑定关系为ButtonBlockKey
    objc_setAssociatedObject(self, CTextFieldAction, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self addTarget:self action:@selector(fieldAction:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
}


- (void)fieldAction:(UITextField *)field {
    
    // 从绑定关系中获取block
    CTextFieldBlock block = objc_getAssociatedObject(self, CTextFieldAction);
    if (block) {
        block(field.tag);
    }
    
    
    
}



@end
