//
//  XYAttributedImage.m
//  Demo
//
//  Created by 吴伟 on 2018/2/13.
//  Copyright © 2018年 fifyrio. All rights reserved.
//

#import "XYAttributedImage.h"

@implementation XYAttributedImage

+ (XYImageType)getImageTypeFromName:(NSString *)name{
    // 加载gif文件数据
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    
    // 获取gif二进制数据
    NSData *gifData = [NSData dataWithContentsOfFile:path];
    
    uint8_t c;
    [gifData getBytes:&c length:1];
    // 根据16进制图片的头部，判断图片是什么类型
    switch (c) {
        case 0x47:
            return XYImageTypeGIF;
            break;
            
        default:
            return XYImageTypePNG;
            break;
    }
}

@end
