//
//  NSMutableAttributedString+XYText.h
//  Demo
//
//  Created by 吴伟 on 2018/2/13.
//  Copyright © 2018年 fifyrio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (XYText)

+ (NSAttributedString *)xy_attributedString:(NSString *)string
                                  textColor:(UIColor *)textColor
                                       font:(UIFont *)font;

@end
