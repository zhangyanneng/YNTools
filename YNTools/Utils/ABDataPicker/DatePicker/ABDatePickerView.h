//
//  ABDatePickerView.h
//  anbang_ios
//
//  Created by 张艳能 on 2017/8/30.
//  Copyright © 2017年 ch. All rights reserved.
//

#import "ABDataBaseView.h"


typedef enum : NSUInteger {
    ABDatePickerModeTime,
    ABDatePickerModeDate,
    ABDatePickerModeYearAndMonth,
    ABDatePickerModeDateAndTime,
    ABDatePickerModeCountDownTimer
} ABDatePickerMode;

typedef void(^ABDateResultBlock)(NSDate *selDate);

@interface ABDatePickerView : ABDataBaseView

@property (nonatomic, copy) ABDateResultBlock dateResultBlock;

/**
 弹出时间选择器

 @param title 标题
 @param model 显示模式
 @param defaultValue 默认时间设置
 @param minDate 显示的最小时间
 @param maxDate 显示的最大时间
 @param resultBlock 选择结果回调
 
 */
+ (void)showDatePickerViewWithTitle:(NSString *)title dateType:(ABDatePickerMode)model defaultDate:(NSDate *)defaultDate minDate:(NSDate *)minDate maxDate:(NSDate *)maxDate resultBlock:(ABDateResultBlock)dateResultBlock;


/**
 使用默认数据，弹出时间选择器

 @param model 时间模式
 @param resultBlock 选择结果回调
 */
+ (void)showDatePickerViewWithDateType:(ABDatePickerMode)model resultBlock:(ABDateResultBlock)dateResultBlock;



@end
