//
//  CCopyLabel.m
//  CToolDemo
//
//  Created by sm on 2019/6/26.
//  Copyright © 2019 cyc. All rights reserved.
//

#import "CCopyLabel.h"

@implementation CCopyLabel


- (void)awakeFromNib {
    [super awakeFromNib];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pressAction:)]];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]){
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pressAction:)]];
    }
    return self;
}

#pragma mark - 长按弹出
- (void)pressAction:(UILongPressGestureRecognizer *)press {
    
    
    if (press.state == UIGestureRecognizerStateBegan) {

        [self becomeFirstResponder];
        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setTargetRect:self.bounds inView:self];
        [menu setMenuVisible:YES animated:YES];
    }
    
}



- (BOOL)canBecomeFirstResponder {
    return YES;
}

/**
 * 通过第一响应者的这个方法告诉UIMenuController可以显示什么内容
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    // 允许copy
    if (action == @selector(copy:) && self.text) {
        return YES;
    }
    
    return NO;
}

- (void)copy:(UIMenuController *)menu {
    // 将label的文字存储到粘贴板
    if (self.text) {
        [UIPasteboard generalPasteboard].string = self.text;
    }
    
}

@end
