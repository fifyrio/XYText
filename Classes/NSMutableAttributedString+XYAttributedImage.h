//
//  NSMutableAttributedString+XYAttributedImage.h
//  Demo
//
//  Created by 吴伟 on 2018/2/13.
//  Copyright © 2018年 fifyrio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYAttributedImage.h"

@interface NSMutableAttributedString (XYAttributedImage)

+ (NSAttributedString *)xy_attributedStringWithImageData:(XYAttributedImage *)imageData;

@end
