//
//  YNTableViewController.m
//  YNTools
//
//  Created by 张艳能 on 2017/12/20.
//  Copyright © 2017年 张艳能. All rights reserved.
//

#import "YNTableViewController.h"
#import "YNDateViewController.h"

@interface YNTableViewController ()

@property (nonatomic,strong) NSArray *dataSources;

@end

@implementation YNTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"测试";
    
    self.dataSources = @[@"添加水印",@"NSDate"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSources.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataSources[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (indexPath.row == 1) {
        YNDateViewController *dateVC = [mainStory instantiateViewControllerWithIdentifier:@"dateVCIdentity"];
        
        [self.navigationController pushViewController:dateVC animated:YES];  
    }
}


@end
