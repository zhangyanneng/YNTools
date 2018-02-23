//
//  ABDatePickerView.m
//  anbang_ios
//
//  Created by 张艳能 on 2017/8/30.
//  Copyright © 2017年 ch. All rights reserved.
//

#import "ABDatePickerView.h"

@interface ABDatePickerView()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    ABDatePickerMode _modelType;
    NSString *_title;
    NSDate *_defaultValue;
    NSDate *_minDate;
    NSDate *_maxDate;
    
    UIPickerView *_pickerView;
    UIDatePicker *_datePicker;
}

@property (nonatomic,strong) NSMutableArray *years;

@property (nonatomic,strong) NSMutableArray *months;

@property (nonatomic,strong) NSDateFormatter *formatter;

@property (nonatomic,strong) NSCalendar *calendar;


@end

@implementation ABDatePickerView

+ (void)showDatePickerViewWithTitle:(NSString *)title dateType:(ABDatePickerMode)model defaultDate:(NSDate *)defaultDate minDate:(NSDate *)minDate maxDate:(NSDate *)maxDate resultBlock:(ABDateResultBlock)resultBlock {
    
    ABDatePickerView *datePickerView = [[ABDatePickerView alloc] initWithTitle:title dateType:model defaultValue:defaultDate minDate:minDate maxDate:maxDate resultBlock:resultBlock];
    
    [datePickerView showWithAnimation:YES];
}

+ (void)showDatePickerViewWithDateType:(ABDatePickerMode)model resultBlock:(ABDateResultBlock)resultBlock {
    [self showDatePickerViewWithTitle:nil dateType:model defaultDate:[NSDate date] minDate:nil maxDate:nil resultBlock:resultBlock];
}


- (instancetype)initWithTitle:(NSString *)title dateType:(ABDatePickerMode)model defaultValue:(NSDate *)defaultValue minDate:(NSDate *)minDate maxDate:(NSDate *)maxDate resultBlock:(ABDateResultBlock)resultBlock {
    
    if (self = [super init]) {
        _title = title;
        _modelType = model;
        _defaultValue = defaultValue ? defaultValue : [NSDate date];
        _minDate = minDate;
        _maxDate = maxDate;
        self.dateResultBlock = resultBlock;
        
        [self _initUI];
    }
    
    return self;
}

- (void)_initUI {
    
    if (_modelType == ABDatePickerModeYearAndMonth) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, kToolBarHeight + 0.5, kScreenWidth, kDatePickerHeight)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        [self.alertView addSubview:_pickerView];
        
        [self setDefualtDate:_defaultValue];
        
    } else {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, kToolBarHeight + 0.5, kScreenWidth, kDatePickerHeight)];
        _datePicker.datePickerMode = [self datePickerModel];
        if (_minDate) _datePicker.minimumDate = _minDate;
        if (_maxDate) _datePicker.maximumDate = _maxDate;
        
        
        [self.alertView addSubview:_datePicker];
    }
}

#pragma mark - UIPickerViewDataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    switch (_modelType) {
        case ABDatePickerModeYearAndMonth:
        {
            //yyyy-mm
            return 2;
        }
        default:
            break;
    }
    return 0;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (_modelType) {
        case ABDatePickerModeYearAndMonth:
        {
            if (component == 0) {
                 if ([self isChineseLanguage]) {
                     return self.years.count;
                 } else {
                     return self.months.count;
                 }
            } else if(component == 1){
               if ([self isChineseLanguage]) {
                    return self.months.count;
                } else {
                    return self.years.count;
                }
            }
        }
        default:
            break;
    }

    return 0;
}

#pragma mark - UIPickerViewDelegate
// returns width of column and height of row for each component.
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return kScreenWidth * 0.5;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 33;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
       if ([self isChineseLanguage]) {
            return [self getDisplayYears:self.years[row]];
        } else {
            return [self getDisplayMonth:self.months[row]];
        }
    } else if(component == 1){
        if ([self isChineseLanguage]) {
            return [self getDisplayMonth:self.months[row]];
        } else {
            return [self getDisplayYears:self.years[row]];
        }
    }

    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
   if ([self isChineseLanguage]) {
        if (component == 0 && pickerView == _pickerView) {
            [pickerView selectRow:0 inComponent:1 animated:YES];
        }
    } else {
        if (component == 1 && pickerView == _pickerView) {
            [pickerView selectRow:0 inComponent:0 animated:YES];
        }
    }
}


#pragma mark - 弹出视图方法
- (void)showWithAnimation:(BOOL)animation {
    //1. 获取当前应用的主窗口
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
    if (animation) {
        // 动画前初始位置
        CGRect rect = self.alertView.frame;
        rect.origin.y = kScreenHeight;
        self.alertView.frame = rect;
        
        // 浮现动画
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = self.alertView.frame;
            rect.origin.y -= kDatePickerHeight + kToolBarHeight;
            self.alertView.frame = rect;
        }];
    }
}


- (void)cancelBtnClick {
    
    // 关闭动画
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = self.alertView.frame;
        rect.origin.y += kDatePickerHeight + kToolBarHeight;
        self.alertView.frame = rect;
        
        self.backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.cancelBtn removeFromSuperview];
        [self.confirmBtn removeFromSuperview];
        [self.titleLabel removeFromSuperview];
        [self.lineView removeFromSuperview];
        [self.toolView removeFromSuperview];
        if(_pickerView) [_pickerView removeFromSuperview];
        if(_datePicker) [_datePicker removeFromSuperview];
        [self.alertView removeFromSuperview];
        [self.backgroundView removeFromSuperview];
        [self removeFromSuperview];
        
        self.cancelBtn = nil;
        self.confirmBtn = nil;
        self.titleLabel = nil;
        self.lineView = nil;
        self.toolView = nil;
        _pickerView = nil;
        _datePicker = nil;
        self.alertView = nil;
        self.backgroundView = nil;
    }];
}


#pragma mark - 时间处理

//使用pickerView时候，设置当前时间
- (void)setDefualtDate:(NSDate *)date {
    
    NSDateComponents *comp = [self.calendar components: NSCalendarUnitYear |
                                 NSCalendarUnitMonth
                                                 fromDate:date];
    
    NSInteger year = comp.year;
    NSInteger month = comp.month;
    
    NSInteger yearRow = [self.years indexOfObject:[NSString stringWithFormat:@"%zd",year]];
    
     if ([self isChineseLanguage]) {
         [_pickerView selectRow:yearRow inComponent:0 animated:NO];
         [_pickerView selectRow:(month - 1) inComponent:1 animated:NO];
     } else {
         [_pickerView selectRow:yearRow inComponent:1 animated:NO];
         [_pickerView selectRow:(month - 1) inComponent:0 animated:NO];
     }
}


- (UIDatePickerMode)datePickerModel {
    UIDatePickerMode model = UIDatePickerModeTime;
    switch (_modelType) {
        case ABDatePickerModeTime:
            model = UIDatePickerModeTime;
            break;
        case ABDatePickerModeDate:
            model = UIDatePickerModeDate;
            break;
        case ABDatePickerModeDateAndTime:
            model = UIDatePickerModeDateAndTime;
            break;
        case ABDatePickerModeCountDownTimer:
            model = UIDatePickerModeCountDownTimer;
            break;
        default:
            break;
    }
    return model;
}

- (NSMutableArray *)years {
    if (_years == nil) {
        _years = [NSMutableArray array];
        
        [self.formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        if (!_minDate) _minDate = [self.formatter dateFromString:@"1990-01-01 00:00:00"];
        if (!_maxDate) _maxDate = [self.formatter dateFromString:@"2100-01-01 00:00:00"];
        
        NSDateComponents *minComp = [self.calendar components: NSCalendarUnitYear |
                                     NSCalendarUnitMonth |
                                     NSCalendarUnitDay
                                                     fromDate:_minDate];
        
        NSDateComponents  *maxComp = [self.calendar components: NSCalendarUnitYear |
                                      NSCalendarUnitMonth |
                                      NSCalendarUnitDay
                                                      fromDate:_maxDate];
        
        
        NSInteger minYear = minComp.year;
        NSInteger maxYear = maxComp.year;
        
        for (NSUInteger i = minYear; i < maxYear; i++) {
            [_years addObject:[NSString stringWithFormat:@"%zd",i]];
        }
        
    }
    
    return _years;
}

- (NSMutableArray *)months {
    if (_months == nil) {
        _months = [[NSMutableArray alloc] init];
        for (NSInteger i = 1; i <= 12; i++) {
            [_months addObject:[NSString stringWithFormat:@"%02zd",i]];
        }
    }
    return _months;
}

//处理显示的日期年份
- (NSString *)getDisplayYears:(NSString *)year {

    NSString *str;
    if ([self isChineseLanguage]) {
        str = [NSString stringWithFormat:@"%@年",year];
    } else {
        str = year;
    }
    return str;
}

- (NSString *)getDisplayMonth:(NSString *)month {
    NSString *str;
   if ([self isChineseLanguage]) {
        str = [NSString stringWithFormat:@"%@月",month];
    } else {

        self.formatter.dateFormat = @"MM";
        NSDate *date = [self.formatter dateFromString:month];
        
        self.formatter.dateFormat = @"MMMM";
        NSString *strFromDate = [self.formatter stringFromDate:date];
        
        str = strFromDate;
    }
    return str;
    
}
//判断当前环境
- (BOOL)isChineseLanguage {
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    // zh-Hans, zh-Hant, 中文环境
    if ([currentLanguage hasPrefix:@"zh-"]) {
        return YES;
    }
    return NO;
}



/** 确定按钮的点击事件 */
- (void)confirmBtnClick {
    
    if (_modelType == ABDatePickerModeYearAndMonth) {
        NSInteger yearRow;
        NSInteger monthRow;
        if ([self isChineseLanguage]) {
            yearRow = [_pickerView selectedRowInComponent:0];
            monthRow = [_pickerView selectedRowInComponent:1];
        } else {
            yearRow = [_pickerView selectedRowInComponent:1];
            monthRow = [_pickerView selectedRowInComponent:0];
        }
        
        NSString *year = self.years[yearRow];
        NSString *month = self.months[monthRow];
    
        self.formatter.dateFormat = @"yyyy-MM";
        NSString *dateStr = [NSString stringWithFormat:@"%@-%@",year,month];
        NSDate *date = [self.formatter dateFromString:dateStr];
        
        if (self.dateResultBlock) {
            self.dateResultBlock(date);
        }
        
    } else {

        if (self.dateResultBlock) {
            self.dateResultBlock(_datePicker.date);
        }
        
    }
    
    [self cancelBtnClick];
    
}


- (NSDateFormatter *)formatter {
    if (_formatter == nil) {
        _formatter = [[NSDateFormatter alloc]init];
        [_formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    }
    return _formatter;
}

- (NSCalendar *)calendar {
    if (_calendar == nil) {
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        _calendar.locale = [NSLocale currentLocale];
        _calendar.timeZone = [NSTimeZone systemTimeZone];
    }
    return _calendar;
}


@end
