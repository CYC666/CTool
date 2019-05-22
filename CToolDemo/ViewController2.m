//
//  ViewController2.m
//  CToolDemo
//
//  Created by sm on 2019/5/21.
//  Copyright © 2019 cyc. All rights reserved.
//

#import "ViewController2.h"
#import "CTool.h"
#import "TableViewCell2.h"

@interface ViewController2 () <UITableViewDelegate, UITableViewDataSource> {
    
    NSMutableArray *dataArray;   // 数据列表
    NSInteger currentPage;
    
}

@property (strong, nonatomic) UITableView *listTableView;

@end

@implementation ViewController2

#pragma mark ========================================生命周期========================================
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = cBgColor;
    dataArray = cNewArr
    // 创建视图
    [self creatSubViewsAction];
    
    
    
}


#pragma mark ========================================私有方法=============================================

#pragma mark - 创建视图
- (void)creatSubViewsAction {
    
    // 表视图
    _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, cScrWid, cScrHei) style:UITableViewStylePlain];
    _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _listTableView.backgroundColor = [UIColor clearColor];
    _listTableView.rowHeight = 62;
    _listTableView.estimatedRowHeight = 0;
    _listTableView.estimatedSectionFooterHeight = 0;
    _listTableView.estimatedSectionHeaderHeight = 0;
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    [_listTableView registerClass:NSClassFromString(@"TableViewCell2") forCellReuseIdentifier:@"TableViewCell2"];
    [self.view addSubview:_listTableView];
    
    if(@available(iOS 11.0, *)){
        _listTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [CTool setNoDateView:_listTableView dataList:dataArray];
    
}

#pragma mark ========================================动作响应=============================================


#pragma mark ========================================网络请求=============================================



#pragma mark ========================================代理方法=============================================

#pragma mark - 表视图代理方法


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        return dataArray.count;
//    return 20;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell2"
                                                            forIndexPath:indexPath];
    
    //    if (indexPath.row < dataArray.count) {
    //        cell.model = dataArray[indexPath.row];
    //    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
}


#pragma mark ========================================通知================================================






































@end
