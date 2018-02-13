//
//  XYText.m
//  Demo
//
//  Created by wuw on 2018/2/12.
//  Copyright © 2018年 fifyrio. All rights reserved.
//

#import "XYText.h"
#import "XYAttributedImage.h"
#import "NSMutableAttributedString+XYAttributedImage.h"
#import "NSMutableAttributedString+XYText.h"
#import "UIImageView+XYGIF.h"
#import "UIView+frameAdjust.h"

@interface XYText ()

# warning 待删除
@property (nonatomic, assign) CTFrameRef frameRef;

@property (nonatomic, retain) NSMutableAttributedString *attributedString;

/**
 * 存放图片数据模型的数组
 */
@property (nonatomic, strong) NSMutableArray *imageArry;

@end

@implementation XYText

- (void)xy_setAttributedString:(NSAttributedString *)attributedString{
    self.attributedString = [NSMutableAttributedString xy_attributedString:attributedString.string textColor:self.xy_textColor font:self.xy_font].mutableCopy;
    
    //编译图片
     self.imageArry = [self _formatImagesWithAttributedString:attributedString font:self.xy_font];
}

#pragma mark - Life cycle
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //翻转坐标系
    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformMakeTranslation(0, rect.size.height), 1.f, -1.f);
    CGContextConcatCTM(context, transform);
    
    //获取CTFrameRef(就是获取frame)
    self.frameRef = [self _getFrameRefWithRect:rect attrString:self.attributedString];
    
    //一行一行的写字
    [self _drawText:self.frameRef];
    
    [self _drawImages:self.frameRef];
}

#pragma mark - private

/**
 将字符串里的图片转化格式加delegate
 */
- (NSMutableArray *)_formatImagesWithAttributedString:(NSAttributedString *)attributedString font:(UIFont *)font{
    NSMutableArray *arr = [self _filterImageWithAttributedString:attributedString].mutableCopy;
    
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)font.fontName, font.pointSize, NULL);
    for (XYAttributedImage *imageData in arr) {
        UIImage *image = [UIImage imageNamed:imageData.imageName];
        
        if (!image) {
            [arr removeObject:imageData];
            continue;
        }
        
        imageData.fontRef = fontRef;
        imageData.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        imageData.imageType = [XYAttributedImage getImageTypeFromName:imageData.imageName];
        
        //图片大小默认与字体大小一致
        imageData.imageSize = CGSizeMake(font.pointSize, font.pointSize);
        
        //设置图片占位符
        NSAttributedString *replaceString = [NSMutableAttributedString xy_attributedStringWithImageData:imageData];
        
        NSString *imageStr = [NSString stringWithFormat:@"[/%@]", imageData.imageName];
        NSRange range = [self.attributedString.string rangeOfString:imageStr];//获取图片在字符串中的位置
        imageData.position = range.location;
        [self.attributedString replaceCharactersInRange:range withAttributedString:replaceString];
    }
    return arr;
}




- (NSArray *)_filterImageWithAttributedString:(NSAttributedString *)attributedString{
    NSMutableArray *arrM = @[].mutableCopy;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\[.*?\\]" options:NSRegularExpressionCaseInsensitive error:nil];
    [regex enumerateMatchesInString:attributedString.string options:0 range:NSMakeRange(0, attributedString.string.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        NSString *resultString = [attributedString.string substringWithRange:result.range];
        if (resultString.length && resultString.length > 3) {
            NSString *imageName = [[resultString substringFromIndex:2] substringToIndex:resultString.length - 3];//获取图片名称
            XYAttributedImage *imageData = [XYAttributedImage new];
            imageData.imageName = imageName;
            [arrM addObject:imageData];
        }
    }];
    return arrM.copy;
}

/**
 获取CTFrameRef(就是获取frame)

 @param rect
 */
- (CTFrameRef)_getFrameRefWithRect:(CGRect)rect attrString:(NSMutableAttributedString *)attrString{
    CTFramesetterRef framesetterRef = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attrString);//获取framesetterRef
    CGMutablePathRef path = CGPathCreateMutable();//创建path
    CGPathAddRect(path, NULL, rect);//添加path
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetterRef, CFRangeMake(0, 0), path, NULL);
    CFRelease(path);
    CFRelease(framesetterRef);
    return frameRef;
}


/**
 一行一行的写字
 */
- (void)_drawText:(CTFrameRef)frameRef{
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


/**
 绘制图片

 @param frameRef
 */
- (void)_drawImages:(CTFrameRef)frameRef{
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    CFArrayRef lines = CTFrameGetLines(frameRef);//获取lineRef数组
    CFIndex lineCount = CFArrayGetCount(lines);//获取lineRef数组的长度
    NSUInteger numberOfLines = lineCount;//默认显示所有文字
    CGPoint lineOrigins[numberOfLines];//将每一行起始位置组成一个数组
    CTFrameGetLineOrigins(frameRef, CFRangeMake(0, numberOfLines), lineOrigins);
    
    for (CFIndex idx = 0; idx < numberOfLines; idx ++) {//遍历每一行
        CTLineRef lineRef = CFArrayGetValueAtIndex(lines, idx);//获取每一行对应的lineRef
        CFArrayRef runs = CTLineGetGlyphRuns(lineRef);
        CFIndex runCount = CFArrayGetCount(runs);
        CGPoint lineOrigin = lineOrigins[idx];
        for (CFIndex idx = 0; idx < runCount; idx ++) {
            CTRunRef runRef = CFArrayGetValueAtIndex(runs, idx);
            NSDictionary *runAttributes = (NSDictionary *)CTRunGetAttributes(runRef);
            CTRunDelegateRef delegate = (__bridge CTRunDelegateRef)([runAttributes valueForKey:(id)kCTRunDelegateAttributeName]);
            if (nil == delegate) {
                continue;//因为我们只给图片设置了CTRunDelegateRef,故不是图片，退出此次循环
            }
            
            //开始绘制图片
            XYAttributedImage *imageData = (XYAttributedImage *)CTRunDelegateGetRefCon(delegate);
            CGRect imageFrame = xy_CTRunGetTypographicBoundsForImageRect(runRef, lineRef, lineOrigin, imageData);
            
            if (imageData.imageType == XYImageTypeGIF) {
                // 初始化imageView
                UIImageView *imageView = [UIImageView xy_imageViewWithGIFName:imageData.imageName frame:imageFrame];
                // 调整imageView的Y坐标
                [imageView setY:self.height - imageView.height - imageView.y];
                [self addSubview:imageView];
            }else{
                CGContextRef context = UIGraphicsGetCurrentContext();
                UIImage *image = [UIImage imageNamed:imageData.imageName];
                CGContextDrawImage(context, imageFrame, image.CGImage);
            }
            
            
        }
    }
}

/**
 * 获取图片的rect
 */
CGRect xy_CTRunGetTypographicBoundsForImageRect(CTRunRef runRef, CTLineRef lineRef, CGPoint lineOrigin, XYAttributedImage *imageData)
{
    // 获取对应runRef的rect
    CGRect rect = xy_CTRunGetTypographicBoundsAsRect(runRef, lineRef, lineOrigin);
    return UIEdgeInsetsInsetRect(rect, imageData.imageInsets);
    
}

/**
 * 获取对应runRef的rect
 */
CGRect xy_CTRunGetTypographicBoundsAsRect(CTRunRef runRef, CTLineRef lineRef, CGPoint lineOrigin)
{
    // 上行高度
    CGFloat ascent;
    // 下行高度
    CGFloat descent;
    // 宽度
    CGFloat width = CTRunGetTypographicBounds(runRef, CFRangeMake(0, 0), &ascent, &descent, NULL);
    // 高度
    CGFloat height = ascent + descent;
    
    // 当前runRef距离lineOrigin的偏移值
    CGFloat offsetX = CTLineGetOffsetForStringIndex(lineRef, CTRunGetStringRange(runRef).location, NULL);
    
    // 返回计算好的rect
    return CGRectMake(lineOrigin.x + offsetX,
                      lineOrigin.y - descent,
                      width,
                      height);
}
@end
