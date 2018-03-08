//
//  XYLabel.m
//  Demo
//
//  Created by wuw on 2018/3/5.
//  Copyright © 2018年 fifyrio. All rights reserved.
//

#import "XYLabel.h"
#import "XYTextLayout.h"

@interface XYLabel ()

@property (nonatomic, strong) XYTextLayout *layout;

@end


@implementation XYLabel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _layout = [XYTextLayout new];
    }
    return self;
}

- (void)setAttributedString:(NSAttributedString *)attributedString{
    _attributedString = attributedString;
    _layout.text = attributedString;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [_layout drawInContext:UIGraphicsGetCurrentContext() size:rect.size];
}


@end
