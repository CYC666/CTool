//
//  CTopTipView.m
//  CToolDemo
//
//  Created by sm on 2019/5/22.
//  Copyright © 2019 cyc. All rights reserved.
//

#import "CTopTipView.h"



#define CTOPTIPVIEWTEXT            @"CTOPTIPVIEWTEXT"
#define CTOPTIPVIEWTEXTFONT        @"CTOPTIPVIEWTEXTFONT"
#define CTOPTIPVIEWTEXTCOLOR       @"CTOPTIPVIEWTEXTCOLOR"
#define CTOPTIPVIEWLBACKGROUPCOLOR @"CTOPTIPVIEWLBACKGROUPCOLOR"
#define CTOPTIPVIEWLOBDISTANCE     @"CTOPTIPVIEWLOBDISTANCE"
#define CTOPTIPVIEWDISPLAYTIME     @"CTOPTIPVIEWDISPLAYTIME"
#define CTOPTIPVIEWANIMATIONTIME   @"CTOPTIPVIEWANIMATIONTIME"

static CTopTipView *instance = nil;
static NSString *CTopTipViewString = @"CTopTipViewStringCTopTipViewStringCTopTipViewStringCTopTipViewStringCTopTipViewStringCTopTipViewString";

@interface CTopTipView ()  {
    
    
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;      // 底部滑动视图
@property (weak, nonatomic) IBOutlet UILabel *textLabel;            // 文字提示
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left;      // 左边约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right;     // 右边约束



@end

@implementation CTopTipView

#pragma mark ========================================初始化=============================================
+ (CTopTipView *)shareTipView {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[[NSBundle mainBundle] loadNibNamed:@"CTopTipView" owner:nil options:nil] firstObject];
        instance.frame = CGRectMake(0, -cNavHei, cScrWid, cNavHei);
        [cWindow addSubview:instance];
        
//        // 初始化
//        [self setObDistance:15];
//        [self setTextColor:cLabColA];
//        [self setTextFont:cFontB];
//        [self setBackgroupColor:[UIColor whiteColor]];
//        [self setDisplayTime:4];
    });
    
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    @synchronized(self) {
        if (!instance) {
            instance = [super allocWithZone:zone];
        }
    }
    return instance;
}



#pragma mark - 刷新UI
- (void)updateUIAction {
    
    // 左右边缘距离
    NSNumber *obDistance = objc_getAssociatedObject(CTopTipViewString, CTOPTIPVIEWLOBDISTANCE);
    self.left.constant = self.right.constant = obDistance.floatValue >= 0 ? obDistance.floatValue : 15;
    
    // 文本颜色
    UIColor *textColor = objc_getAssociatedObject(CTopTipViewString, CTOPTIPVIEWTEXTCOLOR);
    self.textLabel.textColor = textColor ? : cWhiteColor;
    
    // 文本颜色
    UIFont *font = objc_getAssociatedObject(CTopTipViewString, CTOPTIPVIEWTEXTFONT);
    self.textLabel.font = font ? : cFontA;
    
    // 背景颜色
    UIColor *backgroupColor = objc_getAssociatedObject(CTopTipViewString, CTOPTIPVIEWLBACKGROUPCOLOR);
    self.backgroundColor = backgroupColor ? : cLabColA;
    
    // 显示时长
    NSNumber *displayTime = objc_getAssociatedObject(CTopTipViewString, CTOPTIPVIEWDISPLAYTIME);
    displayTime = displayTime.floatValue > 0 ? displayTime : @(1.5);
    
    // 动画时长
    NSNumber *animationTime = objc_getAssociatedObject(CTopTipViewString, CTOPTIPVIEWANIMATIONTIME);
    animationTime = animationTime.floatValue > 0 ? animationTime : @(0.25);
    
    [UIView animateWithDuration:animationTime.floatValue animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, cNavHei);
    } completion:^(BOOL finished) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(displayTime.floatValue * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:animationTime.floatValue animations:^{
                self.transform = CGAffineTransformMakeTranslation(0, 0);
            }];
        });
        
    }];
    
}


#pragma mark ========================================设置属性=============================================

+ (void)setTextColor:(UIColor *)color {
    
    objc_setAssociatedObject(CTopTipViewString, CTOPTIPVIEWTEXTCOLOR, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

+ (void)setTextFont:(UIFont *)font {
    
    objc_setAssociatedObject(CTopTipViewString, CTOPTIPVIEWTEXTFONT, font, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

+ (void)setBackgroupColor:(UIColor *)color {
    
    objc_setAssociatedObject(CTopTipViewString, CTOPTIPVIEWLBACKGROUPCOLOR, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    
}

+ (void)setObDistance:(float)distance {
    
    objc_setAssociatedObject(CTopTipViewString, CTOPTIPVIEWLOBDISTANCE, @(distance), OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

+ (void)setDisplayTime:(float)time {
    
    objc_setAssociatedObject(CTopTipViewString, CTOPTIPVIEWDISPLAYTIME, @(time), OBJC_ASSOCIATION_COPY_NONATOMIC);

}

+ (void)setAnimationTime:(float)time {
    
    objc_setAssociatedObject(CTopTipViewString, CTOPTIPVIEWANIMATIONTIME, @(time), OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}




+ (void)showWithText:(NSString *)text {
    
    [[self shareTipView] showText:text];
    
}


- (void)showText:(NSString *)text {
    
    self.textLabel.text = text;
    [self updateUIAction];
    
    
}


































@end
