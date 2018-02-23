//
//  ABDataBaseView.m
//  anbang_ios
//
//  Created by 张艳能 on 2017/8/30.
//  Copyright © 2017年 ch. All rights reserved.
//

#import "ABDataBaseView.h"
#import "UIColor+YNExtend.h"

@implementation ABDataBaseView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.frame = self.backgroundView.frame;
        
        [self addSubview:self.backgroundView];
        
        [self addSubview:self.alertView];
        
        [self.alertView addSubview:self.toolView];
        
        [self.toolView addSubview:self.cancelBtn];
        
        [self.toolView addSubview:self.confirmBtn];
        
        [self.toolView addSubview:self.titleLabel];
        
        [self.toolView addSubview:self.lineView];
        
        
    }
    return self;
}


#pragma mark - 事件处理
/** 取消按钮的点击事件 */
- (void)cancelBtnClick {
    
    
}

/** 确定按钮的点击事件 */
- (void)confirmBtnClick {
    
    
    
}

/** 点击背景遮罩图层事件 */
- (void)didTapBackgroundView:(UITapGestureRecognizer *)sender {
    
    [self cancelBtnClick];
}



#pragma mark - 背景遮罩图层
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.20];
        _backgroundView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapBackgroundView:)];
        [_backgroundView addGestureRecognizer:tap];
    }
    return _backgroundView;
}

#pragma mark - 弹出视图
- (UIView *)alertView {
    if (!_alertView) {
        _alertView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - kToolBarHeight - kDatePickerHeight, kScreenWidth, kToolBarHeight +kDatePickerHeight)];
        _alertView.backgroundColor = [UIColor whiteColor];
    }
    return _alertView;
}

#pragma mark - 顶部标题栏视图
- (UIView *)toolView {
    if (!_toolView) {
        _toolView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kToolBarHeight + 0.5)];
        _toolView.backgroundColor = [UIColor whiteColor];
    }
    return _toolView;
}

#pragma mark - 左边取消按钮
- (UIButton *)cancelBtn {
    if (_cancelBtn == nil) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(5, 8, 60, 28);
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
        [_cancelBtn setTitleColor: [UIColor colorFromHexString:@"#46A6FF"] forState:UIControlStateNormal];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)confirmBtn {
    if (_confirmBtn == nil) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.frame = CGRectMake(kScreenWidth - 65, 8, 60, 28);
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
        [_confirmBtn setTitleColor:[UIColor colorFromHexString:@"#0084FF"] forState:UIControlStateNormal];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}


#pragma mark - 中间标题按钮
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(65, 0, kScreenWidth - 130, kToolBarHeight)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

#pragma mark - 分割线
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kToolBarHeight, kScreenWidth, 0.5)];
        _lineView.backgroundColor  = [UIColor colorWithRed:225 / 255.0 green:225 / 255.0 blue:225 / 255.0 alpha:1.0];
        [self.alertView addSubview:_lineView];
    }
    return _lineView;
}


@end
