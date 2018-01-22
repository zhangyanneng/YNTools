


//
//  YNDateViewController.m
//  YNTools
//
//  Created by 张艳能 on 2017/12/20.
//  Copyright © 2017年 张艳能. All rights reserved.
//

#import "YNDateViewController.h"
#import "NSDate+YNExtend.h"

@interface YNDateViewController ()
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *hourLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *minuesLabel;
@property (weak, nonatomic) IBOutlet UILabel *weakdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentDate;
@property (weak, nonatomic) IBOutlet UILabel *currentTimestamp;
@property (weak, nonatomic) IBOutlet UILabel *midnightLabel;

@property (weak, nonatomic) IBOutlet UILabel *charToDate;

@end

@implementation YNDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentDate.text = [[NSDate date] stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.currentTimestamp.text = [NSString stringWithFormat:@"时间戳:%@",@([[NSDate date] timeIntervalSince1970])];
    self.dayLabel.text = [NSString stringWithFormat:@"天:%@",@([[NSDate date] day])];
    self.monthLabel.text = [NSString stringWithFormat:@"月:%@",@([[NSDate date] month])];
    self.yearLabel.text = [NSString stringWithFormat:@"年:%@",@([[NSDate date] year])];
    self.hourLabel.text = [NSString stringWithFormat:@"时:%@",@([[NSDate date] hour])];
    self.secondLabel.text = [NSString stringWithFormat:@"秒:%@",@([[NSDate date] second])];
    self.minuesLabel.text = [NSString stringWithFormat:@"分:%@",@([[NSDate date] minute])];
    self.weakdayLabel.text = [NSString stringWithFormat:@"周([1 - Sunday]):%@",@([[NSDate date] weekday])];
    
    self.midnightLabel.text = [[[NSDate date] midnight] stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    NSString *dateString = @"20180115162301";
    NSDate *date = [NSDate dateWithString:@"20180115162301" format:@"yyyyMMddHHmmss"];
    
    
    self.charToDate.text = [date stringWithFormat:@"20180115162301:yyyy-MM-dd HH:mm:ss"];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
