//
//  XWZCustomSegue.m
//  GestureLock
//
//  Created by XinWeizhou on 2017/5/10.
//  Copyright © 2017年 XinWeizhou. All rights reserved.
//

#import "XWZCustomSegue.h"

@implementation XWZCustomSegue
- (void)perform {
    UIViewController *current = self.sourceViewController;
    UIViewController *next = self.destinationViewController;
    next.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;

    [current presentViewController:next animated:YES completion:nil];
//    [current.navigationController pushViewController:next animated:YES];
}
@end
