//
//  ABDataBaseView.h
//  anbang_ios
//
//  Created by 张艳能 on 2017/8/30.
//  Copyright © 2017年 ch. All rights reserved.
//

#import <UIKit/UIKit.h>


#define kToolBarHeight 44
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kDatePickerHeight (kScreenHeight > 811 ? 200 + 34 : 200)

typedef void(^ABDataResultBlock)(NSString *selData);

@interface ABDataBaseView : UIView
// 背景视图
@property (nonatomic, strong) UIView *backgroundView;
// 弹出视图
@property (nonatomic, strong) UIView *alertView;
// 顶部视图
@property (nonatomic, strong) UIView *toolView;
// 左边取消按钮
@property (nonatomic, strong) UIButton *cancelBtn;
// 右边确定按钮
@property (nonatomic, strong) UIButton *confirmBtn;
// 中间标题
@property (nonatomic, strong) UILabel *titleLabel;
// 分割线视图
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, copy) ABDataResultBlock resultBlock;

/** 点击背景遮罩图层事件 */
- (void)didTapBackgroundView:(UITapGestureRecognizer *)sender;

/** 取消按钮的点击事件 */
- (void)cancelBtnClick;

/** 确定按钮的点击事件 */
- (void)confirmBtnClick;

@end
