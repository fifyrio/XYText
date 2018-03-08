//
//  XYTextLayout.h
//  Demo
//
//  Created by wuw on 2018/3/5.
//  Copyright © 2018年 fifyrio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

@interface XYTextLayout : NSObject

+ (instancetype)layoutWithText:(NSAttributedString *)text numberOfLines:(NSUInteger)numberOfLines;

- (void)drawInContext:(CGContextRef)context size:(CGSize)size;

@property (nonatomic, copy) NSAttributedString *text;

@property (nonatomic, assign) NSUInteger numberOfLines;

@end
