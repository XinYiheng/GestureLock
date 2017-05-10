//
//  ViewController.m
//  GestureLock
//
//  Created by XinWeizhou on 2017/5/10.
//  Copyright © 2017年 XinWeizhou. All rights reserved.
//

#import "ViewController.h"
#import "XWZGestureLock.h"
#import "XWZCustomSegue.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet XWZGestureLock *gestureLockView;

@end

@implementation ViewController
- (IBAction)chessViewBtnClicked:(UIButton *)sender {
    [self performSegueWithIdentifier:@"chessSegue" sender:self];
}
- (IBAction)clearBtnClicked:(id)sender {
    [self.gestureLockView clear];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"%s",__func__);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
