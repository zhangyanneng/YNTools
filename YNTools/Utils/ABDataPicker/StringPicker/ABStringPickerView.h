//
//  ABStringPickerView.h
//  anbang_ios
//
//  Created by 张艳能 on 2017/9/1.
//  Copyright © 2017年 张艳能. All rights reserved.
//

#import "ABDataBaseView.h"

@interface ABStringPickerView : ABDataBaseView


+ (void)showPickerViewWithArray:(NSArray *)strings resultBlock:(ABDataResultBlock)resultBlock;

@end
