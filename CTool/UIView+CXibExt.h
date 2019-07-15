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
@property(nonatomic,assign)IBInspectable CGFloat cB_Width;
@property(nonatomic,assign)IBInspectable CGFloat cB_Radius;
@property(nonatomic,strong)IBInspectable UIColor *cB_Color;


// 阴影
@property(nonatomic,assign)IBInspectable CGFloat cS_OffsetX;
@property(nonatomic,assign)IBInspectable CGFloat cS_OffsetY;
@property(nonatomic,assign)IBInspectable CGFloat cS_Radius;
@property(nonatomic,assign)IBInspectable CGFloat cS_Opacity;
@property(nonatomic,strong)IBInspectable UIColor *cS_Color;


@end

NS_ASSUME_NONNULL_END
