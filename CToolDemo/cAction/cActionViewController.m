//
//  cActionViewController.m
//  CToolDemo
//
//  Created by sm on 2019/5/22.
//  Copyright © 2019 cyc. All rights reserved.
//

#import "cActionViewController.h"
#import "CTool.h"

@interface cActionViewController ()

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *field;

@property (weak, nonatomic) IBOutlet UIView *view1;



@end

@implementation cActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"cAvtion";
    
    __weak typeof(self) weakSelf = self;
    
    // 给按钮添加快速响应
    [_button addAction:^(NSInteger tag) {
        
        [weakSelf showAction:weakSelf.button.titleLabel.text];
        
    }];
    
    // 给按标签加快速响应
    [_label addAction:^(NSInteger tag) {
        [weakSelf showAction:weakSelf.label.text];
    }];
    
    // 给图片添加快速响应
    [_imageView addAction:^(NSInteger tag) {
        [weakSelf showAction:[NSString stringWithFormat:@"%ld", weakSelf.imageView.tag]];
    }];
    
    // 给输入框添加快速响应
    [_field addAction:^(NSInteger tag) {
        [weakSelf showAction:weakSelf.field.placeholder];
    }];
    
    cViewBottomRadius(_view1, 15)
    
}

#pragma mark - 显示
- (void)showAction:(NSString *)text {
    
    // 弹框提示是否执行
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:text
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       
                                                   }];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

@end
