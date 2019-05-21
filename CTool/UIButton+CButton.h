//
//  UIButton+CButton.h
//  CToolDemo
//
//  Created by sm on 2019/5/21.
//  Copyright © 2019 cyc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTool.h"

NS_ASSUME_NONNULL_BEGIN


@interface UIButton (CButton)


// 添加响应
- (void)addAction:(CToolBlock)block;

@end

NS_ASSUME_NONNULL_END
