//
//  ViewController.m
//  CToolDemo
//
//  Created by sm on 2019/5/20.
//  Copyright © 2019 cyc. All rights reserved.
//

#import "ViewController.h"
#import "CTool.h"
#import "TopTipViewDemoController.h"
#import "cActionViewController.h"
#import "cParStrViewController.h"
#import "CCopyLabelController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"CToolDemo";
    self.view.backgroundColor = cBgColor;
    
    NSDictionary *dic = @{@"msg":@"成功",
                          @"code":@"200",
                          @"data":@{
                                  @"asdasd":@"asdasdasss",
                                  @"asdas":@"asdasdsss",
                                  @"asdd":@"asdasss",
                                  @"asd":@"asdasdas",
                                  @"assd":@"dasdasss",
                                  }
                          };
    
    
    NSLog(@"%@", [CTool getNslogString:dic]);
    
    
    
}


- (IBAction)button1Action:(id)sender {
    

    [self.navigationController pushViewController:[TopTipViewDemoController new] animated:YES];
    
}

- (IBAction)button2Action:(id)sender {
    

    [self.navigationController pushViewController:[cActionViewController new] animated:YES];
}

- (IBAction)button3Action:(id)sender {
    
    [self.navigationController pushViewController:[cParStrViewController new] animated:YES];
}

- (IBAction)button4Action:(id)sender {
    
    [self.navigationController pushViewController:[CCopyLabelController new] animated:YES];
}


@end
