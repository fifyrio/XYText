//
//  NSAttributedStringTool.m
//  XYHiRepairs
//
//  Created by wuw on 2017/4/28.
//  Copyright © 2017年 Kingnet. All rights reserved.
//

#import "NSAttributedStringTool.h"

@implementation NSAttributedStringTool

+ (NSAttributedString *)formatWithString:(NSString *)string color:(UIColor *)color{
    return [[NSAttributedString alloc] initWithString:string attributes:@{NSForegroundColorAttributeName: color}];
}


+ (NSAttributedString *)formatWithString:(NSString *)string color:(UIColor *)color font:(UIFont *)font{
    return [[NSAttributedString alloc] initWithString:string attributes:@{NSForegroundColorAttributeName: color, NSFontAttributeName:font}];
}

+ (NSAttributedString *)formatWithStrings:(NSArray <NSString *>*)strings colors:(NSArray <UIColor *> *)colors fonts:(NSArray <UIFont *> *)fonts{
    if (!strings.count || !colors.count || !fonts.count) {
        return nil;
    }
    
    NSString *text = [[strings valueForKey:@"description"] componentsJoinedByString:@""];
    NSDictionary *attribs = @{NSForegroundColorAttributeName: [UIColor blackColor],
                              NSFontAttributeName: [UIFont systemFontOfSize:16]
                              };
    NSMutableAttributedString *attributedText =
    [[NSMutableAttributedString alloc] initWithString:text
                                           attributes:attribs];
    for (int i = 0; i < strings.count; i++) {
        NSRange textRange = [text rangeOfString:strings[i]];
        [attributedText setAttributes:@{
                                        NSFontAttributeName:fonts[i],
                                        NSForegroundColorAttributeName : colors[i]
                                        }
                                range:textRange];
    }
    return [attributedText copy];
}

+ (CGFloat)calculateHeightWithString:(NSAttributedString *)string inWidth:(CGFloat)width{
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  context:nil];
    
    return rect.size.height;
}

@end
