//
//  NSMutableAttributedString+XYText.m
//  Demo
//
//  Created by 吴伟 on 2018/2/13.
//  Copyright © 2018年 fifyrio. All rights reserved.
//

#import "NSMutableAttributedString+XYText.h"

// 行间距
static CGFloat kLineSpacing = 3.f;
// 段间距
static CGFloat kParagraphSpacing = 5.f;

@implementation NSMutableAttributedString (XYText)

/**
 * 根据传入的属性和字符串，返回对应的属性字符串
 */
+ (NSAttributedString *)xy_attributedString:(NSString *)string
                               textColor:(UIColor *)textColor
                                    font:(UIFont *)font
{
    // 设置段落样式
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = kLineSpacing;
    paragraphStyle.paragraphSpacing = kParagraphSpacing;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByCharWrapping;
    
    // 设置文本属性字典
    NSDictionary *attributes = @{
                                 NSFontAttributeName : font,
                                 NSForegroundColorAttributeName : textColor,
                                 NSParagraphStyleAttributeName : paragraphStyle
                                 };
    // 初始化可变字符串
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string attributes:attributes];
    
    return attString;
}

@end
