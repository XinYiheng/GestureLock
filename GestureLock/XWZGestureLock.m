//
//  XWZGestureLock.m
//  GestureLock
//
//  Created by XinWeizhou on 2016/7/12.
//  Copyright © 2016年 XinWeizhou. All rights reserved.
//

#import "XWZGestureLock.h"

@interface XWZGestureLock()

@property (nonatomic , strong) NSMutableArray *btns;
@property (nonatomic , assign) CGPoint moveP;

@end

@implementation XWZGestureLock {
    BOOL _end;
}

- (NSMutableArray *)btns {
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        NSLog(@"%s",__func__);
    }
    return self;
}

// 解析Xib的时候调用
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        // 添加按钮
        [self addBtns];
        NSLog(@"%s",__func__);
        
    }
    return self;
}

// 添加按钮
- (void)addBtns {
    NSLog(@"%s",__func__);
    for (int i = 0; i < 9; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        // 设置普通状态下的图片
        [button setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        
        [button setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        
        // 不允许用户交互
        button.userInteractionEnabled = NO;
        //        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        [self addSubview:button];
    }
}
- (void)clear {
//    [self.btns makeObjectsPerformSelector:@selector(setSelected:) withObject:@NO];
    
    [self.btns enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = NO;
    }];
    
    [self.btns removeAllObjects];
    [self setNeedsDisplay];
}
// 获取触摸点
- (CGPoint)pointWithTouches:(NSSet *)touches {
    // 当前触摸点
    UITouch *touch = [touches anyObject];
    return  [touch locationInView:self];
}
// 获取触摸按钮
- (UIButton *)buttonWithPoint:(CGPoint)point {
    for (UIButton *btn in self.subviews) {
        if (CGRectContainsPoint(btn.frame, point)){ // 点在按钮上
            return btn;
        }
    }
    
    return nil;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    _end = NO;
    // 当前触摸点
    CGPoint pos = [self pointWithTouches:touches];
    
    
    // 获取触摸按钮
    UIButton *btn = [self buttonWithPoint:pos];
    
    if (btn && btn.selected == NO) { // 有触摸按钮的时候才需要选中
        
        btn.selected = YES;
        [_btns addObject:btn];
    }
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    // 当前触摸点
    CGPoint pos = [self pointWithTouches:touches];
    
    _moveP = pos;
    // 获取触摸按钮
    UIButton *btn = [self buttonWithPoint:pos];
    
    if (btn && btn.selected == NO) { // 有触摸按钮的时候才需要选中
        
        btn.selected = YES;
        
        [_btns addObject:btn];
    }
    
    // 重绘
    [self setNeedsDisplay];
    
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _end = YES;
    [self setNeedsDisplay];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat col = 0;
    CGFloat row = 0;
    
    CGFloat btnW = 74;
    CGFloat btnH = 74;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    
    CGFloat tolCol = 3;
    CGFloat margin = (self.bounds.size.width - tolCol * btnW) / (tolCol + 1);
    
    // 给按钮设置位置
    for (int i = 0; i < self.subviews.count; i++) {
        UIButton *button = self.subviews[i];
        
        col = i % 3;
        row = i / 3;
        btnX = margin + (margin + btnW) * col;
        btnY = (margin + btnH) * row;
        
        button.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
    }
    
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    for (int i = 0; i < self.btns.count; i++) {
        UIButton *btn = _btns[i];
        if (i == 0) {
            [path moveToPoint:btn.center];
        } else {
            [path addLineToPoint:btn.center];
        }
    }
    
    // 所有选中按钮之间都连线
    if (_end == NO) {
        // 连接多余的那根线
        [path addLineToPoint:_moveP];
    }
    
    
    [[UIColor greenColor] set];
    path.lineWidth = 8;
    path.lineJoinStyle = kCGLineJoinRound;
    
    // 渲染到视图
    [path stroke];
  
}


@end
