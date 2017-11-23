//
//  ViewController.m
//  XMGraffiti
//
//  Created by mifit on 2017/11/22.
//  Copyright © 2017年 Mifit. All rights reserved.
//

#import "ViewController.h"
#import "XMGraffitiView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    XMGraffitiView *view = [[XMGraffitiView alloc]init];
    [self.view addSubview:view];
    view.frame = CGRectMake(10, 10, 300, 500);
    view.backgroundColor = [UIColor yellowColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
