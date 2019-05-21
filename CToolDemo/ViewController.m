//
//  ViewController.m
//  CToolDemo
//
//  Created by sm on 2019/5/20.
//  Copyright © 2019 cyc. All rights reserved.
//

#import "ViewController.h"
#import "CTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UIView *View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cScrWid, cScrHei)];
    View.backgroundColor = [UIColor blackColor];
    [self.view addSubview:View];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cScrWid, cScrHei)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    label.font = cFontA;
    [self.view addSubview:label];

    NSString *str = @"上篇文章[Cocoapods]项目添加Cocoapods支持主要介绍了添加Cocoapods支持的大致过程, 当然文章看上去是一帆风顺的. 但是, 事实并不是这样. 上篇文章篇幅过长, 就把之间遇到的一些问题, 单独写了出来.";
    
    cParStr(label, str, 3);
    

    
}


@end
