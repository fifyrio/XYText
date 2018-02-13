//
//  XYAttributedImage.h
//  Demo
//
//  Created by 吴伟 on 2018/2/13.
//  Copyright © 2018年 fifyrio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

typedef NS_ENUM(NSUInteger, XYImageType) {
    XYImageTypePNG,
    XYImageTypeGIF,
    XYImageTypeJPEG,
    XYImageTypeJPG,
};

@interface XYAttributedImage : NSObject

@property (nonatomic, strong) NSString *imageName;

/**
 * 占位图片属性字符的字体fontRef
 * ->此处为方便计算Ascent和Descent
 */
@property (nonatomic, assign) CTFontRef fontRef;

/**
 * 图片的位置
 */
@property (nonatomic, assign) NSInteger position;

/**
 * 图片与文字的上下左右的间距
 */
@property (nonatomic, assign) UIEdgeInsets imageInsets;

@property (nonatomic, assign) XYImageType imageType;

/**
 * 图片大小
 */
@property (nonatomic, assign) CGSize imageSize;

+ (XYImageType)getImageTypeFromName:(NSString *)name;

@end
