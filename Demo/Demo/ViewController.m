//
//  ViewController.m
//  Demo
//
//  Created by wuw on 16/6/15.
//  Copyright © 2016年 fifyrio. All rights reserved.
//

#import "ViewController.h"
#import "XYText.h"
#import "XYLabel.h"

@interface ViewController ()

@end

@implementation ViewController
#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
 
    /**/
    XYText *text = [[XYText alloc] initWithFrame:CGRectMake(0, 100, ScreenW, 100)];
    [text setBackgroundColor:[UIColor grayColor]];
    text.xy_font = [UIFont systemFontOfSize:22];
    text.xy_textColor = [UIColor whiteColor];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"your attributed strings, [/haha], and fuck you, 额副科级的空间[/cahan.gif]反馈[/haqian.gif]点击[/haha.gif]"];
    [text xy_setAttributedString:attrString];
    [self.view addSubview:text];
}

- (IBAction)onClickRun:(id)sender {
    XYLabel *label = [[XYLabel alloc] initWithFrame:CGRectMake(0, 100, ScreenW, 100)];
    
}

@end
