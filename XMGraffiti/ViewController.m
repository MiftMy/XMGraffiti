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
{
}
@property (weak, nonatomic) IBOutlet XMGraffitiView *graffitiView;
@property (weak, nonatomic) IBOutlet UISwitch *swBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)swValueChanged:(id)sender {
    self.graffitiView.isEraser = self.swBtn.isOn;
}
- (IBAction)undo:(id)sender {
    [self.graffitiView undo];
}
- (IBAction)redo:(id)sender {
    [self.graffitiView redo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
