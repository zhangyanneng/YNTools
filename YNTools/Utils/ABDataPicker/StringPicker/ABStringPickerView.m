//
//  ABStringPickerView.m
//  anbang_ios
//
//  Created by 张艳能 on 2017/9/1.
//  Copyright © 2017年 张艳能. All rights reserved.
//

#import "ABStringPickerView.h"

@interface ABStringPickerView()<UIPickerViewDataSource,UIPickerViewDelegate>

//字符串数组
@property (nonatomic,strong) NSArray *strings;

@end

@implementation ABStringPickerView
{
    UIPickerView *_pickerView;
    NSInteger _selRow;
    NSInteger _selComponent;
    
}

+ (void)showPickerViewWithArray:(NSArray *)strings resultBlock:(ABDataResultBlock)resultBlock {
    
    ABStringPickerView *picker = [[ABStringPickerView alloc] init];
    picker.strings = strings;
    picker.resultBlock = resultBlock;
    
    [picker showWithAnimation:YES];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self _initUI];
        
        [self _initDefualtValue];
        
    }
    return self;
}



- (void)_initUI {
    
    _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, kToolBarHeight + 0.5, kScreenWidth, kDatePickerHeight)];
    _pickerView.backgroundColor = [UIColor whiteColor];
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    
    [self.alertView addSubview:_pickerView];
    
}

- (void)_initDefualtValue {
    
    [_pickerView selectRow:1 inComponent:0 animated:NO];
}

#pragma mark -UIPickerViewDataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.strings.count;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    _selRow = row;
    _selComponent = component;
    
}

#pragma mark - UIPickerViewDelegate
// returns width of column and height of row for each component.
//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
//    return 80;
//}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 33;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return self.strings[row];
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSString *string = self.strings[row];

    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:string];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, string.length)];
//    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, string.length)];
    
    return attrStr;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    
    UILabel *label = (UILabel *)view;
    if (label == nil) {
        label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:19];
    }
    
    label.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    return label;
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
        [_pickerView removeFromSuperview];
        [self.alertView removeFromSuperview];
        [self.backgroundView removeFromSuperview];
        [self removeFromSuperview];
        
        self.cancelBtn = nil;
        self.confirmBtn = nil;
        self.titleLabel = nil;
        self.lineView = nil;
        self.toolView = nil;
        _pickerView = nil;
        self.alertView = nil;
        self.backgroundView = nil;
    }];
}

/** 确定按钮的点击事件 */
- (void)confirmBtnClick {
    
    
    NSString *selStr = self.strings[_selRow];
    
    if (self.resultBlock) {
        self.resultBlock(selStr);
    }
    
    [self cancelBtnClick];
    
}


@end
