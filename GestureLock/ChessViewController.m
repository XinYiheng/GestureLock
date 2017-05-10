//
//  ChessViewController.m
//  GestureLock
//
//  Created by XinWeizhou on 2017/5/10.
//  Copyright © 2017年 XinWeizhou. All rights reserved.
//

#import "ChessViewController.h"

@interface ChessViewController ()

@end

@implementation ChessViewController
- (IBAction)dismissAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
