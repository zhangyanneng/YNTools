//
//  UIColor+YNExtend.h
//  YNTools
//
//  Created by 张艳能 on 2018/2/23.
//  Copyright © 2018年 张艳能. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (YNExtend)

+ (UIColor *)colorFromHexString:(NSString *)hexString;

+ (UIColor *)colorFromHexString:(NSString *)hexString alpha:(CGFloat)alpha;


@end
