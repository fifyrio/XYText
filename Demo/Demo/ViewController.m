//
//  ViewController.m
//  Demo
//
//  Created by wuw on 16/6/15.
//  Copyright © 2016年 fifyrio. All rights reserved.
//

#import "ViewController.h"
#import "XYText.h"

@interface ViewController ()

@end

@implementation ViewController
#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)onClickRun:(id)sender {
    XYText *text = [[XYText alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    [text setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:text];
}

@end
