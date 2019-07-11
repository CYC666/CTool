//
//  UIView+CXibExt.h
//  CToolDemo
//
//  Created by sm on 2019/7/11.
//  Copyright © 2019 cyc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CXibExt)

//IB_DESIGNABLE    //让你的自定 UIView 可以在 IB 中预览


// IBInspectable 作用:让你的自定义 UIView 的属性出现在 IB 中 Attributes inspector

// 描边
@property(nonatomic,assign)IBInspectable CGFloat cBoderWidth;
@property(nonatomic,assign)IBInspectable CGFloat cBoderRadius;
@property(nonatomic,strong)IBInspectable UIColor *cBoderColor;


// 阴影
@property(nonatomic,assign)IBInspectable CGFloat cShadowOffsetX;
@property(nonatomic,assign)IBInspectable CGFloat cShadowOffsetY;
@property(nonatomic,assign)IBInspectable CGFloat cShadowRadius;
@property(nonatomic,assign)IBInspectable CGFloat cShadowOpacity;
@property(nonatomic,strong)IBInspectable UIColor *cShadowColor;


@end

NS_ASSUME_NONNULL_END
