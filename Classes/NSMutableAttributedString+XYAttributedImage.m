//
//  NSMutableAttributedString+XYAttributedImage.m
//  Demo
//
//  Created by 吴伟 on 2018/2/13.
//  Copyright © 2018年 fifyrio. All rights reserved.
//

#import "NSMutableAttributedString+XYAttributedImage.h"

@implementation NSMutableAttributedString (XYAttributedImage)

+ (NSAttributedString *)xy_attributedStringWithImageData:(XYAttributedImage *)imageData{
    CTRunDelegateCallbacks callbacks;
    memset(&callbacks, 0, sizeof(CTRunDelegateCallbacks));
    callbacks.version = kCTRunDelegateVersion1;
    callbacks.getAscent = ascentCallback;
    callbacks.getDescent = descentCallback;
    callbacks.getWidth = widthCallback;
    CTRunDelegateRef runDelegate = CTRunDelegateCreate(&callbacks, (__bridge void *)(imageData));//创建CTRunDelegate
    unichar objectReplacementChar = 0XFFFC;
    NSString *string = [NSString stringWithCharacters:&objectReplacementChar length:1];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    [attrString addAttribute:(NSString *)kCTRunDelegateAttributeName value:(__bridge id)(runDelegate) range:NSMakeRange(0, 1)];
    CFRelease(runDelegate);
    return attrString.copy;
}


/**
 * 获取占位图片的最终大小
 */
static CGSize attributedImageSize(XYAttributedImage *imageData)
{
    CGFloat width = imageData.imageSize.width + imageData.imageInsets.left + imageData.imageInsets.right;
    CGFloat height = imageData.imageSize.height+ imageData.imageInsets.top  + imageData.imageInsets.bottom;
    return CGSizeMake(width, height);
}

/**
 * 获取图片的Ascent
 * height = ascent + descent
 */
static CGFloat ascentCallback(void *ref)
{
    // 1.获取imageData
    XYAttributedImage *imageData = (__bridge XYAttributedImage *)ref;
    
    // 2.获取图片的高度
    CGFloat imageHeight = attributedImageSize(imageData).height;
    
    // 3.获取图片对应占位属性字符串的Ascent和Descent
    CGFloat fontAscent  = CTFontGetAscent(imageData.fontRef);
    CGFloat fontDescent = CTFontGetDescent(imageData.fontRef);
    
    // 4.计算基线->Ascent和Descent分割线
    CGFloat baseLine = (fontAscent + fontDescent) / 2.f - fontDescent;
    
    // 5.获得正确的Ascent
    return imageHeight / 2.f + baseLine;
}

/**
 * 获取图片的Descent
 * height = ascent + descent
 */
static CGFloat descentCallback(void *ref)
{
    // 1.获取imageData
    XYAttributedImage *imageData = (__bridge XYAttributedImage *)ref;
    
    // 2.获取图片的高度
    CGFloat imageHeight = attributedImageSize(imageData).height;
    
    // 3.获取图片对应占位属性字符串的Ascent和Descent
    CGFloat fontAscent  = CTFontGetAscent(imageData.fontRef);
    CGFloat fontDescent = CTFontGetDescent(imageData.fontRef);
    
    // 4.计算基线->Ascent和Descent分割线
    CGFloat baseLine = (fontAscent + fontDescent) / 2.f - fontDescent;
    
    // 5.获得正确的Ascent
    return imageHeight / 2.f - baseLine;
}

/**
 * 获取图片的宽度
 */
static CGFloat widthCallback(void *ref)
{
    // 1.获取imageData
    XYAttributedImage *imageData = (__bridge XYAttributedImage *)ref;
    // 2.获取图片宽度
    return attributedImageSize(imageData).width;
}

@end
