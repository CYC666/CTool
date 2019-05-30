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

#pragma mark -
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














@end
