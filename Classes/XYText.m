//
//  XYText.m
//  Demo
//
//  Created by wuw on 2018/2/12.
//  Copyright © 2018年 fifyrio. All rights reserved.
//

#import "XYText.h"

@interface XYText ()

/**
 * frameRef
 */
@property (nonatomic, assign) CTFrameRef frameRef;

@end

@implementation XYText


- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"your attributed strings, and fuck you"];
    
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //翻转坐标系
    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformMakeTranslation(0, rect.size.height), 1.f, -1.f);
    CGContextConcatCTM(context, transform);
    
    //获取CTFrameRef(就是获取frame)
    CTFramesetterRef framesetterRef = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attrString);//获取framesetterRef
    CGMutablePathRef path = CGPathCreateMutable();//创建path
    CGPathAddRect(path, NULL, rect);//添加path
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetterRef, CFRangeMake(0, 0), path, NULL);
    CFRelease(path);
    CFRelease(framesetterRef);
    
    //一行一行的写字
    CFArrayRef lines = CTFrameGetLines(frameRef);//获取lineRef数组
    CFIndex lineCount = CFArrayGetCount(lines);//获取lineRef数组的长度
    NSUInteger numberOfLines = lineCount;//默认显示所有文字
    CGPoint lineOrigins[numberOfLines];//将每一行起始位置组成一个数组
    CTFrameGetLineOrigins(frameRef, CFRangeMake(0, numberOfLines), lineOrigins);
    for (CFIndex idx = 0; idx < numberOfLines; idx ++) {//遍历每一行
        CGContextRef context = UIGraphicsGetCurrentContext();//获取每一行的上下文
        CTLineRef lineRef = CFArrayGetValueAtIndex(lines, idx);//每一行对应的lineRef
        CGContextSetTextPosition(context, lineOrigins[idx].x, lineOrigins[idx].y);//设置每一行的起始绘制位置
        CTLineDraw(lineRef, context);
    }
}

@end
