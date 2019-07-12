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
#import "CTimer.h"

@interface ViewController ()

@property (strong, nonatomic) CTimer *timer;

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
    
    NSString *S = @"%@asdasdasd";
    NSString *s = @"a";
    
    NSString *ss = [NSString stringWithFormat:S, s];
    NSLog(@"%@", ss);
    
    UIButton *B = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    
    cBtnSelector(B, button1Action:)
    
    
    _timer = [[CTimer alloc] initWithFireTime:1
                                      interval:0.2
                                        target:self
                                      selector:@selector(timerAction:)
                                       repeats:YES];
    [_timer fire];
    
    
//    UIButton *bu = [[UIButton alloc] initWithFrame:CGRectMake(0, 400, cScrWid, cScrHei)];
//    bu.backgroundColor = cBgColor;
//    [self.view addSubview:bu];
//    
//    cBtnSelector(bu, button1Action:)
    
}

#pragma mark - 定时器响应
- (void)timerAction:(CTimer *)timer {
    
    NSLog(@"timer");
    
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
