//
//  XYTextLayout.m
//  Demo
//
//  Created by wuw on 2018/3/5.
//  Copyright © 2018年 fifyrio. All rights reserved.
//

#import "XYTextLayout.h"

@interface XYTextLayout ()



@end

@implementation XYTextLayout

+ (instancetype)layoutWithText:(NSAttributedString *)text numberOfLines:(NSUInteger)numberOfLines{
    XYTextLayout *layout = [[self class] init];
    layout.text = text;
    layout.numberOfLines = numberOfLines;
    return layout;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)drawInContext:(CGContextRef)context size:(CGSize)size{
    XYTextDrawText(self, context, size);
}

static void XYTextDrawText(XYTextLayout *layout, CGContextRef context, CGSize size){
    CGContextSaveGState(context); {
        
        CGContextSetTextMatrix(context, CGAffineTransformIdentity);
        //向上平移一个视图高度的距离
        CGContextTranslateCTM(context, 0, size.height);
        //围绕x轴的翻转
        CGContextScaleCTM(context, 1.0, -1.0);
        
        // 创建绘制区域
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, CGRectMake(0, 0, size.width, size.height));
        
        //排版
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)layout.text);
        CTFrameRef frameRef = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [layout.text length]), path, NULL);
        
        CFArrayRef lines = CTFrameGetLines(frameRef);//获取lineRef数组
        CFIndex lineCount = CFArrayGetCount(lines);//获取lineRef数组的长度
        NSUInteger numberOfLines = lineCount;//默认显示所有文字
        CGPoint lineOrigins[numberOfLines];//将每一行起始位置组成一个数组
        CTFrameGetLineOrigins(frameRef, CFRangeMake(0, numberOfLines), lineOrigins);
        
        /*
        for (CFIndex idx = 0; idx < numberOfLines; idx ++) {//遍历每一行
            CGContextRef curContext = UIGraphicsGetCurrentContext();//获取每一行的上下文
            CTLineRef lineRef = CFArrayGetValueAtIndex(lines, idx);//每一行对应的lineRef
            CGContextSetTextPosition(curContext, lineOrigins[idx].x, lineOrigins[idx].y);//设置每一行的起始绘制位置
            CTLineDraw(lineRef, curContext);
        }
         */
        
    } CGContextRestoreGState(context);
}

@end
