//
//  TopTipViewDemoController.m
//  CToolDemo
//
//  Created by sm on 2019/5/22.
//  Copyright © 2019 cyc. All rights reserved.
//

#import "TopTipViewDemoController.h"
#import "CTopTipView.h"

@interface TopTipViewDemoController ()

@end

@implementation TopTipViewDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"TopTipViewDemo";
    
    // 初始化
    [CTopTipView setObDistance:20];
    [CTopTipView setTextColor:[UIColor darkTextColor]];
    [CTopTipView setTextFont:[UIFont systemFontOfSize:15]];
    [CTopTipView setBackgroupColor:[UIColor whiteColor]];
    [CTopTipView setDisplayTime:3];
    
    
}

- (IBAction)showAction:(id)sender {
    
    [CTopTipView showWithText:@"还有一种办法让cell不闪动，那就是不使用自动约束，在cell布局前，先将cell的尺寸计算出来。这样子即使修改布局高度，reloadData还是一样稳，很美观。"];

    
}



@end
