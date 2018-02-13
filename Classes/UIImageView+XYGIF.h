//
//  UIImageView+XYGIF.h
//  Demo
//
//  Created by 吴伟 on 2018/2/13.
//  Copyright © 2018年 fifyrio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (XYGIF)

+ (UIImageView *)xy_imageViewWithGIFName:(NSString *)imageName
                                   frame:(CGRect)frame;

@end
