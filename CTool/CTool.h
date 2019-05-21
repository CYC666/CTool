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


//===================================================尺寸=====================================================
#define cFit                    ([UIScreen mainScreen].bounds.size.width/375.0)                            // 与375屏的比例
#define cScrWid                 [UIScreen mainScreen].bounds.size.width                                 // 屏幕宽度
#define cScrHei                 [UIScreen mainScreen].bounds.size.height                                // 屏幕高度
#define cNavSta                 [UIApplication sharedApplication].statusBarFrame.size.height            // 状态栏高度
#define cNavHei                 (kNavSta > 20 ? 88 : 64)                                                // 导航栏高度
#define cTabHei                 (kNavSta > 20 ? 83 : 49)                                                // 标签栏高度
#define cSafhei                 (kNavSta > 20 ? 34 : 0)                                                 // 安全区域高度

//===================================================颜色=====================================================
#define cRGB(R,G,B,A)           [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define cHexColA(hexValue, a)   [UIColor colorWithRed:(((hexValue & 0xFF0000) >> 16))/255.0f green:(((hexValue & 0xFF00) >> 8))/255.0f blue:((hexValue & 0xFF))/255.0f alpha:a]
#define cHexCol(hexValue)       cHexColA(hexValue, 1.0f)
#define cBgColor                cHexCol(0xEEEEEE)
#define cSVPColor               cHexCol(0xE0E0E0)
#define cWhiteColor             cHexCol(0xFFFFFF)
#define cBlackColor             cHexCol(0x000000)
#define cLabColA                cHexCol(0x333333)
#define cLabColB                cHexCol(0x666666)
#define cLabColC                cHexCol(0x999999)
#define cStaLig                 [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
#define cStaDar                 [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

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

//===================================================空检测=====================================================
#define cStrEmpty(str)          ([str isKindOfClass:[NSNull class]] || [str isEqualToString:@"<null>"] || str == nil || [str length] < 1 ? YES : NO )
#define cArrEmpty(array)        (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
#define cDicEmpty(dic)          (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
#define cObjEmpty(_object)      (_object == nil \
                                || [_object isKindOfClass:[NSNull class]] \
                                || ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
                                || ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

//===================================================宏对象=====================================================
#define cDefault                [NSUserDefaults standardUserDefaults]
#define cDelegat                (AppDelegate *)[UIApplication sharedApplication].delegate

//===================================================迅设=====================================================
#define cImage(N)               [UIImage imageNamed:N]
#define cButTitle(B,T)          [B setTitle:T forState:UIControlStateNormal];
#define cButColor(B,C)          [B setTitleColor:CforState:UIControlStateNormal];
#define cButImage(B,N)          [B setImage:cImage(N) forState:UIControlStateNormal];
#define cURL(S)                 [NSURL URLWithString:(S)]
#define cNewArr                 [NSMutableArray array];
// 圆角
#define cVieRad(V,R)            [V.layer setCornerRadius:(R)]; [V.layer setMasksToBounds:YES];
// 描边
#define cVieRadBor(V,R,C,W)     [V.layer setCornerRadius:(R)];[V.layer setMasksToBounds:YES];[V.layer setBorderColor:[C CGColor]];[V.layer setBorderWidth:(W)];
// 富文本行间距
#define cParStr(Lab,S,L)        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:S];\
                                NSMutableParagraphStyle *paragrah = [[NSMutableParagraphStyle alloc] init];\
                                paragrah.lineSpacing = L;\
                                paragrah.paragraphSpacing = L;\
                                [string addAttribute:NSParagraphStyleAttributeName value:paragrah range:NSMakeRange(0, string.length)];\
                                Lab.attributedText = string;
// 版本号
#define cAppVersion             [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
// 打开连接
#define cOpenUrl(s)             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:S]];
// 收起键盘
#define cHideKeyBoard           [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
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



@end

NS_ASSUME_NONNULL_END
