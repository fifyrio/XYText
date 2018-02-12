//
//  NSAttributedStringTool.h
//  XYHiRepairs
//
//  Created by wuw on 2017/4/28.
//  Copyright © 2017年 Kingnet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedStringTool : NSObject

+ (NSAttributedString *)formatWithString:(NSString *)string color:(UIColor *)color;

+ (NSAttributedString *)formatWithString:(NSString *)string color:(UIColor *)color font:(UIFont *)font;

+ (NSAttributedString *)formatWithStrings:(NSArray <NSString *>*)strings colors:(NSArray <UIColor *> *)colors fonts:(NSArray <UIFont *> *)fonts;

+ (CGFloat)calculateHeightWithString:(NSAttributedString *)string inWidth:(CGFloat)width;

@end
