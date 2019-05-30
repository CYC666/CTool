//
//  cParStrViewController.m
//  CToolDemo
//
//  Created by sm on 2019/5/22.
//  Copyright © 2019 cyc. All rights reserved.
//

#import "cParStrViewController.h"
#import "CTool.h"

@interface cParStrViewController ()

@end

@implementation cParStrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"cParStr";
    self.view.backgroundColor = cBgColor;
    
    UIView *View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cScrWid, cScrHei)];
    View.backgroundColor = [UIColor blackColor];
    [self.view addSubview:View];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cScrWid, cScrHei)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    label.font = cFontA;
    [self.view addSubview:label];

    NSString *str = @"还有一种办法让cell不闪动，那就是不使用自动约束，在cell布局前，先将cell的尺寸计算出来。这样子即使修改布局高度，reloadData还是一样稳，很美观。";
    cParStr(label, str, 3);
    
//    NSString *str1 = @"2312.0000123100";
//    NSString *str2 = [CTool forEightDecimalString:str1];
//
//    cParStr(label, str2, 3);

    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
