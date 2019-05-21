//
//  CTool.m
//  CToolDemo
//
//  Created by sm on 2019/5/20.
//  Copyright © 2019 cyc. All rights reserved.
//

#import "CTool.h"
#import <objc/runtime.h>

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


@end
