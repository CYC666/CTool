//
//  CTool.m
//  CToolDemo
//
//  Created by sm on 2019/5/20.
//  Copyright © 2019 cyc. All rights reserved.
//

#import "CTool.h"


@implementation CTool


#pragma mark - 给表视图上没有数据的页面
+ (void)setNoDateView:(UITableView *)tableView dataList:(NSArray *)dataList {
    
    // 没有数据的视图
    dispatch_async(dispatch_get_main_queue(), ^{
        

        if (dataList.count == 0) {
            
            UIView *cycNoData = objc_getAssociatedObject(tableView, @"cycNoData");
            if (!cycNoData) {
                
                UIView *view = [[UIView alloc] initWithFrame:tableView.bounds];
                view.backgroundColor = tableView.backgroundColor;
                
                UIImageView *noDataImage = [[UIImageView alloc] initWithImage:cBundleImage(@"CToolImages", @"NoDataImage")];
                noDataImage.center = CGPointMake(tableView.bounds.size.width * 0.5, tableView.bounds.size.height * 0.4);
                [view addSubview:noDataImage];
                [tableView addSubview:view];
                
                objc_setAssociatedObject(tableView, @"cycNoData", view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            
        } else {
            
            UIView *cycNoData = objc_getAssociatedObject(tableView, @"cycNoData");
            if (cycNoData) {
                [cycNoData removeFromSuperview];
                cycNoData = nil;
            }
            
        }
        
        [tableView reloadData];
        
    });
    
}

#pragma mark - 小数的转换
+ (NSString *)forTwoDecimalString:(NSString *)str {
    str = [NSString stringWithFormat:@"%.2f", str.floatValue];
    return [self forDecimalString:str];
}
+ (NSString *)forThreeDecimalString:(NSString *)str {
    str = [NSString stringWithFormat:@"%.3f", str.floatValue];
    return [self forDecimalString:str];
}
+ (NSString *)forFourDecimalString:(NSString *)str {
    str = [NSString stringWithFormat:@"%.4f", str.floatValue];
    return [self forDecimalString:str];
}
+ (NSString *)forSixDecimalString:(NSString *)str {
    str = [NSString stringWithFormat:@"%.6f", str.floatValue];
    return [self forDecimalString:str];
}
+ (NSString *)forEightDecimalString:(NSString *)str {
    str = [NSString stringWithFormat:@"%.8f", str.floatValue];
    return [self forDecimalString:str];
}

+ (NSString *)forDecimalString:(NSString *)str {
    
    // 从最后一位不是0或.留下
    for (NSInteger i = str.length - 1; i > 0; i--) {
        
        NSString *c = [str substringWithRange:NSMakeRange(i, 1)];
        
        if ([c isEqualToString:@"0"]) {
            continue;
        } else if ([c isEqualToString:@"."]) {
            return [str substringToIndex:i];
        } else {
            return [str substringToIndex:i+1];
        }
        
    }
    
    return @"0";
    
}


+ (NSString *)getNslogString:(id)obj {
    
    // 使用runtime储存、获取层级，从而确定\t的数量。设置后要及时清除，不然会与下次请求冲突
    NSString *level = objc_getAssociatedObject(obj, @"OBJ_LEVEL");
    NSString *levelTip; // \t个数
    if (cStrEmpty(level)) {
        level = @"0";
        levelTip = @"\t";
    } else if (level.intValue == 1) {
        levelTip = @"\t\t";
    } else if (level.intValue == 2) {
        levelTip = @"\t\t\t";
    } else if (level.intValue == 3) {
        levelTip = @"\t\t\t";
    } else {
        levelTip = @"\t\t\t\t";
    }
    NSString *subLevel = [NSString stringWithFormat:@"%d", level.intValue + 1];
    
    if ([obj isKindOfClass:[NSDictionary class]]) {
        
        // 字典
        NSMutableString *string = [NSMutableString string];
        NSDictionary *dic = (NSDictionary *)obj;
        [string appendString:@"{"];
        for (NSInteger i = 0; i < dic.allKeys.count; i++) {
            
            // 设置下一层及的level
            objc_setAssociatedObject(dic.allKeys[i], @"OBJ_LEVEL", subLevel, OBJC_ASSOCIATION_COPY_NONATOMIC);
            objc_setAssociatedObject(dic.allValues[i], @"OBJ_LEVEL", subLevel, OBJC_ASSOCIATION_COPY_NONATOMIC);
            [string appendFormat:@"\n%@%@ = %@", levelTip, [self getNslogString:dic.allKeys[i]], [self getNslogString:dic.allValues[i]]];
            if (i != dic.allKeys.count-1) {
                [string appendString:@","];
            }
            
            // 清除层级level
            objc_removeAssociatedObjects(dic.allKeys[i]);
            objc_removeAssociatedObjects(dic.allValues[i]);
            
        }
        [string appendFormat:@"\n%@}", levelTip];
        return string;
        
    } else if ([obj isKindOfClass:[NSArray class]]) {
        
        // 数组
        NSMutableString *string = [NSMutableString string];
        NSArray *array = (NSArray *)obj;
        [string appendString:@"["];
        for (NSInteger i = 0; i < array.count; i++) {
            
            // 设置下一层及的level
            objc_setAssociatedObject(array[i], @"OBJ_LEVEL", subLevel, OBJC_ASSOCIATION_COPY_NONATOMIC);
            [string appendFormat:@"\n%@%@", levelTip, [self getNslogString:array[i]]];
            if (i != array.count-1) {
                [string appendString:@","];
            }
            
            // 清除层级level
            objc_removeAssociatedObjects(array[i]);
        }
        [string appendFormat:@"\n%@]", levelTip];
        return string;
        
    } else {
        
        // 其他,直接返回
        return [NSString stringWithFormat:@"\"%@\"", obj];
        
    }
    
    
}

#pragma mark - 绘制渐变色颜色的方法
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(UIColor *)fromHexColor toColor:(UIColor *)toHexColor{
    
    //    CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    
    //  创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = @[(__bridge id)fromHexColor.CGColor,(__bridge id)toHexColor.CGColor];
    
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    //startPoint & endPoint设置为(0,0)(1.0, 0)代表水平方向渐变,(0,0)(0, 1.0)代表竖直方向渐变
    //  设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@0.0,@1.0];
    
    return gradientLayer;
}


#pragma mark - 根据属性数组，创建一个Label
+ (UILabel *)getLabelWithArray:(NSArray *)list {
    
    UILabel *label = [[UILabel alloc] init];
    
    for (id obj in list) {
        
        if ([obj isKindOfClass:[UIColor class]]) {
            
            label.textColor = obj;
        } else if ([obj isKindOfClass:[NSString class]]) {
            
            label.text = obj;
        } else if ([obj isKindOfClass:[UIFont class]]) {
            
            label.font = obj;
        } else if ([obj isKindOfClass:[NSNumber class]]) {
            
            NSNumber *value = (NSNumber *)obj;
            label.numberOfLines = value.integerValue;
        } else if ([obj isKindOfClass:[NSValue class]]) {
            
            NSValue *value = (NSValue *)obj;
            if (memcmp(value.objCType, "{CGRect={CGPoint=dd}{CGSize=dd}}", 32) == 0) {
                
                label.frame = value.CGRectValue;
            } else if (memcmp(value.objCType, "{CGPoint=dd}", 12) == 0) {
                
                label.center = value.CGPointValue;
            }
        } else if ([obj isKindOfClass:[NSDictionary class]]) {
            
            NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:label.text];
            [attString addAttributes:(NSDictionary *)obj range:NSMakeRange(0, label.text.length)];
            label.attributedText = attString;
            
        } else if ([obj isKindOfClass:[UIView class]]) {
            
            [(UIView *)obj addSubview:label];
        }
    }
    
    return label;
}


#pragma mark - 根据属性数组，创建一个UIbutton
+ (UIButton *)getButtonWithArray:(NSArray *)list {
    
    UIButton *button = [[UIButton alloc] init];
    
    for (id obj in list) {
        
        if ([obj isKindOfClass:[UIColor class]]) {
            
            [button setTitleColor:obj forState:UIControlStateNormal];
        } else if ([obj isKindOfClass:[NSString class]]) {
            
            [button setTitle:obj forState:UIControlStateNormal];
        } else if ([obj isKindOfClass:[UIFont class]]) {
            
            button.titleLabel.font = obj;
        } else if ([obj isKindOfClass:[NSNumber class]]) {
            
            NSNumber *value = (NSNumber *)obj;
            button.titleLabel.numberOfLines = value.integerValue;
        } else if ([obj isKindOfClass:[NSValue class]]) {
            
            NSValue *value = (NSValue *)obj;
            if (memcmp(value.objCType, "{CGRect={CGPoint=dd}{CGSize=dd}}", 32) == 0) {
                
                button.frame = value.CGRectValue;
            } else if (memcmp(value.objCType, "{CGPoint=dd}", 12) == 0) {
                
                button.center = value.CGPointValue;
            }
        } else if ([obj isKindOfClass:[NSDictionary class]]) {
            
            NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:button.titleLabel.text];
            [attString addAttributes:(NSDictionary *)obj range:NSMakeRange(0, button.titleLabel.text.length)];
            [button setAttributedTitle:attString forState:UIControlStateNormal];
            
        } else if ([obj isKindOfClass:[UIView class]]) {
            
            [(UIView *)obj addSubview:button];
        }
    }
    
    return button;
}

#pragma mark - 根据属性数组，创建一个Label
+ (UITextField *)getFieldWithArray:(NSArray *)list {
    
    UITextField *field = [[UITextField alloc] init];
    
    for (id obj in list) {
        
        if ([obj isKindOfClass:[UIColor class]]) {
            
            field.textColor = obj;
        } else if ([obj isKindOfClass:[NSString class]]) {
            
            field.placeholder = obj;
        } else if ([obj isKindOfClass:[UIFont class]]) {
            
            field.font = obj;
        } else if ([obj isKindOfClass:[NSNumber class]]) {
            
            
        } else if ([obj isKindOfClass:[NSValue class]]) {
            
            NSValue *value = (NSValue *)obj;
            if (memcmp(value.objCType, "{CGRect={CGPoint=dd}{CGSize=dd}}", 32) == 0) {
                
                field.frame = value.CGRectValue;
            } else if (memcmp(value.objCType, "{CGPoint=dd}", 12) == 0) {
                
                field.center = value.CGPointValue;
            }
        } else if ([obj isKindOfClass:[NSDictionary class]]) {
            
            NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:field.text];
            [attString addAttributes:(NSDictionary *)obj range:NSMakeRange(0, field.text.length)];
            field.attributedText = attString;
            
        } else if ([obj isKindOfClass:[UIView class]]) {
            
            [(UIView *)obj addSubview:field];
        }
    }
    
    return field;
}




@end
