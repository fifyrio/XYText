//
//  XYText.h
//  Demo
//
//  Created by wuw on 2018/2/12.
//  Copyright © 2018年 fifyrio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface XYText : UIView

@property (nonatomic, strong) UIFont *xy_font;

@property (nonatomic, strong) UIColor *xy_textColor;

- (void)xy_setAttributedString:(NSAttributedString *)attributedString;

@end
