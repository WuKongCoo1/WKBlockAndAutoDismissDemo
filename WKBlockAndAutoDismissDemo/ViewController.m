//
//  ViewController.m
//  WKBlockAndAutoDismissDemo
//
//  Created by 吴珂 on 2017/5/26.
//  Copyright © 2017年 世纪阳天. All rights reserved.
//

#import "ViewController.h"
#import "UIAlertController+WKBlockAndAutoDismiss.h"

@interface ViewController ()

@property (nonatomic, copy) NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = @[@"auto dismiss alert", @"show action sheet", @"show alert"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITableViewDataSource

- (void)configureCell:(UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.text = self.dataSource[indexPath.row];
}


#pragma mark - UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:{
            [UIAlertController showAlertWithTitle:@"提示" message:@"自动消失"];
        }
            break;
        case 1:{
            [self showActionSheet:cell];
        }
            break;
        case 2:{
            [self showAlert:cell];
        }
            break;
        default:
            break;
    }
}

- (void)showAlert:(UIView *)sender
{
    [UIAlertController showAlertWithTitle:@"alert"
                                  message:@"show alert"
                        cancelButtonTitle:@"cancel" destructiveButtonTitle:@"红色"
                                   action:^(NSInteger index) {
                                       
                                   }
                        otherButtonTitles:@"11111", @"22222", nil];
}

- (void)showActionSheet:(UIView *)sender
{
//    WKPopoverPresentationControllerBlock block = ^(UIPopoverPresentationController *popPresenter){
//        popPresenter.sourceRect = sender.bounds;
//        popPresenter.sourceView = sender;
//    };
    [UIAlertController showActionSheetWithTitle:@"action sheet"
                                        message:@"show action sheet"
                              cancelButtonTitle:@"取消"
                         destructiveButtonTitle:@"红色"
             popoverPresentationControllerBlock:nil
                                         action:^(NSInteger index) {
                                            
                                         }
                              otherButtonTitles:@"11111", @"22222", nil];
}

@end
