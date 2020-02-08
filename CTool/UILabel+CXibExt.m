//
//  UILabel+CXibExt.m
//  CToolDemo
//
//  Created by sm on 2019/7/16.
//  Copyright © 2019 cyc. All rights reserved.
//

#import "UILabel+CXibExt.h"
#import "CTool.h"

@implementation UILabel (CXibExt)




- (void)setColor333:(BOOL)Color333 {
    if (Color333) {
        self.textColor = cHexColor(0x333333);
    }
}
- (BOOL)Color333 {
    return NO;
}

- (void)setColor666:(BOOL)Color666 {
    if (Color666) {
        self.textColor = cHexColor(0x666666);
    }
}
- (BOOL)Color666 {
    return NO;
}

- (void)setColor999:(BOOL)Color999 {
    if (Color999) {
        self.textColor = cHexColor(0x999999);
    }
}
- (BOOL)Color999 {
    return NO;
}






















































@end
