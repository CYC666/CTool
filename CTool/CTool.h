//
//  CTool.h
//  CToolDemo
//
//  Created by sm on 2019/5/20.
//  Copyright © 2019 cyc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

// 工具类
#import "UIButton+CButton.h"
#import "UILabel+CLabel.h"
#import "UIView+CAction.h"
#import "UIImageView+CImageView.h"
#import "UITextField+CTextField.h"
#import "CTopTipView.h"
#import "UIView+CToast.h"
#import "CCopyLabel.h"
#import "UIView+CXibExt.h"
#import "CTimer.h"
#import "UIView+cFrame.h"



//===================================================尺寸=====================================================
#define cFit                    ([UIScreen mainScreen].bounds.size.width/375.0)                            // 与375屏的比例
#define cScreenWidth            [UIScreen mainScreen].bounds.size.width                                 // 屏幕宽度
#define cScreenHeight           [UIScreen mainScreen].bounds.size.height                                // 屏幕高度
#define cNavStart               [UIApplication sharedApplication].statusBarFrame.size.height            // 状态栏高度
#define cNavHeight              (cNavStart > 20 ? 88 : 64)                                                // 导航栏高度
#define cTabHeight              (cNavStart > 20 ? 83 : 49)                                                // 标签栏高度
#define cSafeHeight             (cNavStart > 20 ? 34 : 0)                                                 // 安全区域高度
#define cX(v)                   (v).frame.origin.x
#define cY(v)                   (v).frame.origin.y
#define cW(v)                   (v).frame.size.width
#define cH(v)                   (v).frame.size.height
#define cMinX(v)            CGRectGetMinX((v).frame) // 获得控件屏幕的x坐标
#define cMinY(v)            CGRectGetMinY((v).frame) // 获得控件屏幕的Y坐标
#define cMidX(v)            CGRectGetMidX((v).frame) //横坐标加上到控件中点坐标
#define cMidY(v)            CGRectGetMidY((v).frame) //纵坐标加上到控件中点坐标
#define cMaxX(v)            CGRectGetMaxX((v).frame) //横坐标加上控件的宽度
#define cMaxY(v)            CGRectGetMaxY((v).frame) //纵坐标加上控件的高度
#define cFrame(X,Y,W,H)  CGRectMake(X, Y, W, H) //适配

//===================================================颜色=====================================================
#define cRGB(R,G,B,A)           [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define cHexColorA(hexValue, a)   [UIColor colorWithRed:(((hexValue & 0xFF0000) >> 16))/255.0f green:(((hexValue & 0xFF00) >> 8))/255.0f blue:((hexValue & 0xFF))/255.0f alpha:a]
#define cHexColor(hexValue)       cHexColorA(hexValue, 1.0f)
#define cBgColor                [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1]     // 这个背景色好看些
#define cSVPColor               cHexColor(0xE0E0E0)
#define cWhiteColor             cHexColor(0xFFFFFF)
#define cBlackColor             cHexColor(0x000000)
#define cClearColor             [UIColor clearColor]
#define cLabColA                cHexColor(0x333333)
#define cLabColB                cHexColor(0x666666)
#define cLabColC                cHexColor(0x999999)
#define cStatusLight            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
#define cStatusDark             [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

//===================================================字体=====================================================
#define cPfMedium(S)            [UIFont fontWithName:@"PingFangSC-Medium" size:S]
#define cPfRegular(S)           [UIFont fontWithName:@"PingFangSC-Regular" size:S]
#define cPfSemibold(S)          [UIFont fontWithName:@"PingFangSC-Semibold" size:S]
#define cFontA [UIFont          fontWithName:@"PingFangSC-Medium" size:17]
#define cFontB [UIFont          fontWithName:@"PingFangSC-Medium" size:15]
#define cFontC [UIFont          fontWithName:@"PingFangSC-Medium" size:13]
#define cFontD [UIFont          fontWithName:@"PingFangSC-Regular" size:17]
#define cFontE [UIFont          fontWithName:@"PingFangSC-Regular" size:15]
#define cFontF [UIFont          fontWithName:@"PingFangSC-Regular" size:13]
#define cLabelFont(L,F)         L.font = F;

//===================================================空检测=====================================================
#define cStrEmpty(str)          ([str isKindOfClass:[NSNull class]] || [str isEqualToString:@"<null>"] || str == nil || [str length] < 1 ? YES : NO )
#define cArrEmpty(array)        (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
#define cDicEmpty(dic)          (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
#define cObjEmpty(_object)      (_object == nil \
                                || [_object isKindOfClass:[NSNull class]] \
                                || ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
                                || ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

//===================================================通知=====================================================
#define cNotifiAdd(S,N)       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(S) name:N object:nil];
#define cNotifiPost(N)          [[NSNotificationCenter defaultCenter] postNotificationName:N object:nil];
#define cNotifiDel(N)         [[NSNotificationCenter defaultCenter] removeObserver:self name:N object:nil];


//===================================================字符串=====================================================
#define cStrIsEqual(S,s)        [S isEqualToString:s]
#define cStrFormat(S,s)         [NSString stringWithFormat:S, s]
#define cURL(S)                 [NSURL URLWithString:(S)]
#define cParStr(Lab,S,L)        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:S];\
                                NSMutableParagraphStyle *paragrah = [[NSMutableParagraphStyle alloc] init];\
                                paragrah.lineSpacing = L;\
                                paragrah.paragraphSpacing = L;\
                                [string addAttribute:NSParagraphStyleAttributeName value:paragrah range:NSMakeRange(0, string.length)];\
                                Lab.attributedText = string;

//===================================================按钮=====================================================
#define cBtnTitle(B,T)          [B setTitle:T forState:UIControlStateNormal];
#define cBtnColor(B,C)          [B setTitleColor:C forState:UIControlStateNormal];
#define cBtnImage(B,N)          [B setImage:[UIImage imageNamed:N] forState:UIControlStateNormal];
#define cBtnSelector(B,S)       [B addTarget:self action:@selector(S) forControlEvents:UIControlEventTouchUpInside];
#define cBtnFont(B,F)           B.titleLabel.font = F;
//===================================================沙盒=====================================================
#define cPathDocument           [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#define cPathCache              [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

//===================================================单例对象=====================================================
#define cDefault                [NSUserDefaults standardUserDefaults]
#define cDelegat                (AppDelegate *)[UIApplication sharedApplication].delegate

//===================================================视图=====================================================
#define cViewRadius(V,R)                     [V.layer setCornerRadius:(R)]; [V.layer setMasksToBounds:YES];
#define cViewBorder(V,R,C,W)            [V.layer setCornerRadius:(R)];[V.layer setMasksToBounds:YES];[V.layer setBorderColor:[C CGColor]];[V.layer setBorderWidth:(W)];
#define cViewShadow(V,X,Y,R,O,C)     V.layer.shadowOffset = CGSizeMake(X, Y); V.layer.shadowRadius = R; V.layer.shadowOpacity = O; V.layer.shadowColor = C.CGColor;
#define cViewFocusRadius(V,C,R)     UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:V.bounds byRoundingCorners:C cornerRadii:CGSizeMake(R, R)]; \
                                                CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init]; \
                                                maskLayer.frame = V.bounds; \
                                                maskLayer.path = maskPath.CGPath; \
                                                V.layer.mask = maskLayer;
#define cViewTopRadius(V,R)  cViewFocusRadius(V,UIRectCornerTopRight | UIRectCornerTopLeft,R)
#define cViewBottomRadius(V,R)  cViewFocusRadius(V,UIRectCornerBottomRight | UIRectCornerBottomLeft,R)


//===================================================图片=====================================================
#define cImage(N)               [UIImage imageNamed:N]

//===================================================其他=====================================================
#define cNewArr                 [NSMutableArray array];
// 版本号
#define cAppVersion             [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
// 打开连接
#define cOpenUrl(S)             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:S]];
// 主窗口
#define cWindow                 [UIApplication sharedApplication].keyWindow
// 收起键盘
#define cHideKeyBoard           [cWindow endEditing:YES];
// 触感
#define cFeed                   if (@available(iOS 10.0, *)) { [[[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight] impactOccurred]; }
// 获取Bundle中的image
#define cBundleImage(B,N)       [[UIImage alloc] initWithContentsOfFile:[[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.bundle", B]] stringByAppendingPathComponent:N]]



typedef void(^CToolBlock)(id _Nullable obj);


NS_ASSUME_NONNULL_BEGIN

@interface CTool : NSObject



/**
 给表示头添加暂无数据页面

 @param tableView 表视图
 @param dataList 表视图数据源
 */
+ (void)setNoDateView:(UITableView *)tableView dataList:(NSArray *)dataList;


/**
 123.1239283 -> 123.12
 123.1000000 -> 123.1
 123.0123122 -> 123.01
 123.0000000 -> 123
 */
+ (NSString *)forTwoDecimalString:(NSString *)str;
+ (NSString *)forThreeDecimalString:(NSString *)str;
+ (NSString *)forFourDecimalString:(NSString *)str;
+ (NSString *)forSixDecimalString:(NSString *)str;
+ (NSString *)forEightDecimalString:(NSString *)str;

/**
 将对象转换成字符串

 @param obj 对象
 @return 对象的字符串
 */
+ (NSString *)getNslogString:(id)obj;

//绘制渐变色颜色的方法
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(UIColor *)fromHexColor toColor:(UIColor *)toHexColor;

// 根据属性数值，创建一个Label
+ (UILabel *)getLabelWithArray:(NSArray *)list;

// 根据属性数值，创建一个Button
+ (UIButton *)getButtonWithArray:(NSArray *)list;

// 根据属性数值，创建一个Field
+ (UITextField *)getFieldWithArray:(NSArray *)list;


@end

NS_ASSUME_NONNULL_END
