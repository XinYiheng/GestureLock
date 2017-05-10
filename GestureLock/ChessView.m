//
//  ChessView.m
//  GestureLock
//
//  Created by XinWeizhou on 2016/7/12.
//  Copyright © 2016年 XinWeizhou. All rights reserved.
//

#import "ChessView.h"

// 棋子半径
static NSInteger len = 40;

// 起始点坐标
static NSInteger xPos = 30;
static NSInteger yPos = 80;

// 行数和列数
static NSInteger row = 10;
static NSInteger column = 9;

// 可放棋子标识的间隔和长度
static NSInteger space = 3;
static NSInteger spaceLen = 5;


@implementation ChessView {
    BOOL _chessItem;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self drawChess];
}

#pragma mark - 画棋盘和棋子
- (void)drawChess {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetRGBFillColor(context, 29.0/255.0, 156.0/255.0, 215.0/255.0, 1.0);
    CGContextFillRect(context, CGRectMake(xPos, yPos, len*(column-1), len*(row-1)));
    
    CGContextSetRGBStrokeColor(context, 1, 0, 1, 1.0);
    CGContextSetLineWidth(context, 1.0);
    
    for (int i=0; i<row; i++)
    {
        CGContextMoveToPoint(context, xPos, i*len+yPos);
        CGContextAddLineToPoint(context, xPos+len*(column-1), i*len+yPos);
    }
    
    for (int j=0; j<column; j++)
    {
        if(j==0 || j==column-1)
        {
            CGContextMoveToPoint(context, xPos+j*len, yPos);
            CGContextAddLineToPoint(context, xPos+j*len, yPos+(row-1)*len);
        }
        else
        {
            CGContextMoveToPoint(context, xPos+j*len, yPos);
            CGContextAddLineToPoint(context, xPos+j*len, yPos+(row/2-1)*len);
            CGContextMoveToPoint(context, xPos+j*len, yPos+(row/2)*len);
            CGContextAddLineToPoint(context, xPos+j*len, yPos+(row-1)*len);
        }
    }
    
    CGContextMoveToPoint(context, xPos+3*len, yPos);
    CGContextAddLineToPoint(context, xPos+5*len, yPos+2*len);
    CGContextMoveToPoint(context, xPos+3*len, yPos+2*len);
    CGContextAddLineToPoint(context, xPos+5*len, yPos);
    
    CGContextMoveToPoint(context, xPos+3*len, yPos+(row-1)*len);
    CGContextAddLineToPoint(context, xPos+5*len, yPos+(row-1-2)*len);
    CGContextMoveToPoint(context, xPos+3*len, yPos+(row-1-2)*len);
    CGContextAddLineToPoint(context, xPos+5*len, yPos+(row-1)*len);
    
    for (int i=0; i<row; i++)
    {
        for (int j=0; j<column; j++)
        {
            CGPoint point = [self getPoint:i column:j];
            if(i==3 || i==6)
            {
                if(j%2==0)
                {
                    [self drawFlag:point row:i column:j context:context];
                }
            }
            else if (i==2 || i==7)
            {
                if(j==1 || j==7)
                {
                    [self drawFlag:point row:i column:j context:context];
                }
            }
        }
    }
    
    CGContextStrokePath(context);
    
    [self addItems:context];
    
}

#pragma mark - 获得某行某列的棋盘上点坐标
- (CGPoint)getPoint:(NSInteger)row column:(NSInteger)column {
    return CGPointMake(xPos+column*len, yPos+row*len);
}

#pragma mark - 画可放棋子的标识
- (void)drawFlag:(CGPoint)point row:(NSInteger)newRow column:(NSInteger)newColumn context:(CGContextRef)context {
    if(newColumn != 0) {
        // left top
        CGContextMoveToPoint(context, point.x-space-spaceLen, point.y-space);
        CGContextAddLineToPoint(context, point.x-space, point.y-space);
        CGContextMoveToPoint(context, point.x-space, point.y-space);
        CGContextAddLineToPoint(context, point.x-space, point.y-space-spaceLen);
        // left bottom
        CGContextMoveToPoint(context, point.x-space-spaceLen, point.y+space);
        CGContextAddLineToPoint(context, point.x-space, point.y+space);
        CGContextMoveToPoint(context, point.x-space, point.y+space);
        CGContextAddLineToPoint(context, point.x-space, point.y+space+spaceLen);
    }
    if(newColumn != column-1) {
        // right top
        CGContextMoveToPoint(context, point.x+space, point.y-space);
        CGContextAddLineToPoint(context, point.x+space+spaceLen, point.y-space);
        CGContextMoveToPoint(context, point.x+space, point.y-space);
        CGContextAddLineToPoint(context, point.x+space, point.y-space-spaceLen);
        
        // right bottom
        CGContextMoveToPoint(context, point.x+space, point.y+space);
        CGContextAddLineToPoint(context, point.x+space+spaceLen, point.y+space);
        CGContextMoveToPoint(context, point.x+space, point.y+space);
        CGContextAddLineToPoint(context, point.x+space, point.y+space+spaceLen);
        
    }
}

#pragma mark - 添加所有棋子
- (void)addItems:(CGContextRef)context {
    if (_chessItem == NO) return;
    
    for (int i=0; i<row; i++)
    {
        for (int j=0; j<column; j++)
        {
            if(i==0 || i==row-1)
            {
                [self addChessItem:i colume:j contect:context];
            }
            else if (i==2 || i==row-3)
            {
                if(j==1 || j==column-2)
                {
                    [self addChessItem:i colume:j contect:context];
                }
            }
            else if (i==3 || i==row-4)
            {
                if(j%2==0)
                {
                    [self addChessItem:i colume:j contect:context];
                }
            }
        }
    }
}

#pragma mark - 在指定位置绘制棋子
- (void)addChessItem:(NSInteger)newRow colume:(NSInteger)newColumn contect:(CGContextRef)context {
    CGPoint point = [self getPoint:newRow column:newColumn];
    // 半径
    NSInteger radius = len/2;
    // 颜色
    float red = 1;
    float green = 0;
    float blue = 1;
    if(newRow<row/2) {
        red = 1;
        green = 0;
        blue = 0;
    } else {
        red = 0;
        green = 0;
        blue = 0;
    }
    CGContextAddArc(context, point.x, point.y, radius, 0, 2*M_PI, 0);
    CGContextSetRGBFillColor(context, red, green, blue, 1.0);
    CGContextFillPath(context);
    
    point = CGPointMake(point.x-8, point.y-8);
    [[self getTitle:newRow column:newColumn] drawAtPoint:point withAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}

#pragma mark - 根据行号和列号返回显示的棋子
- (NSString *)getTitle:(NSInteger)newRow column:(NSInteger)newColumn
{
    NSArray *redArray = [NSArray arrayWithObjects:@"車",@"馬",@"相",@"仕",@"帥",@"仕",@"相",@"馬",@"車", nil];
    NSArray *blackArray = [NSArray arrayWithObjects:@"車",@"馬",@"象",@"士",@"將",@"士",@"象",@"馬",@"車", nil];
    NSString *result = @"";
    switch (newRow)
    {
        case 0:
            result = [redArray objectAtIndex:newColumn];
            break;
        case 9:
            result = [blackArray objectAtIndex:newColumn];
            break;
        case 2:
        case 7:
            result = @"炮";
            break;
        case 3:
            result = @"兵";
            break;
        case 6:
            result = @"卒";
        default:
            break;
    }
    return result;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _chessItem = !_chessItem;
    [self setNeedsDisplay];
    NSLog(@"%s",__func__);
}


@end
