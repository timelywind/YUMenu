//
//  YUMenuTwo.m
//  YUMenu
//
//  Created by administrator on 16/9/6.
//  Copyright © 2016年 xuanYuLin. All rights reserved.


#import "YUMenuTwo.h"

#define kCenter CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5)
//两个按钮间的圆弧距离
#define kSpace 50

//button的大小
#define kButtonW 50

@interface YUMenuTwo ()

@property (nonatomic, weak) UIImageView *folderImageView;

// 是否触碰到menu
@property (nonatomic, assign) BOOL isTouchedMenu;

@end

@implementation YUMenuTwo

- (void)setBtns:(NSArray *)btns{
    _btns = btns;
    
    for (int i = 0; i< btns.count; i++) {
        UIButton *btn = btns[i];
        btn.bounds = CGRectMake(0, 0, kButtonW * 0.8, kButtonW * 0.8);
        btn.center = kCenter;
        [self addSubview:btn];
    }
    
    [self bringSubviewToFront:_folderImageView];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imgView = [[UIImageView alloc] init];
        _folderImageView = imgView;
        imgView.image = [UIImage imageNamed:@"folder"];
        imgView.bounds = self.bounds;
        imgView.center = kCenter;
        imgView.userInteractionEnabled = YES;
        
        [self addSubview:imgView];
        
        // 添加点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        tap.numberOfTapsRequired = 1;
        [imgView addGestureRecognizer:tap];
    }
    return self;
}


/**
 *  tap响应
 */
- (void)tap:(UITapGestureRecognizer *)sender{
    [self disperse];
}

/**
 *  按钮散开
 */
- (void)disperse{
    
    CGFloat startAngle = 0.0;
    CGFloat angle = 2 * M_PI / _btns.count;
    CGFloat rad = kSpace / angle;
    
    for (int i = 0; i< _btns.count; i++) {
        CGFloat x = rad * cos(angle * i + startAngle);
        CGFloat y = rad * sin(angle * i + startAngle);
        UIButton *btn = _btns[i];
        [UIView animateWithDuration:0.05 delay:0.05*i options:UIViewAnimationOptionCurveLinear animations:^{
            btn.transform = CGAffineTransformIsIdentity(btn.transform) ? CGAffineTransformMakeTranslation(x, y) : CGAffineTransformIdentity;
        } completion:nil];
    }
}

/**
 *  按钮收回
 */
- (void)changeFrameWithPoint:(CGPoint)point{
    
    self.center = point;
    
    for (int i = 0; i< _btns.count; i++) {
        UIButton *btn = _btns[i];
        [UIView animateWithDuration:0.05 delay:0.05*i options:UIViewAnimationOptionCurveLinear animations:^{
            btn.transform = CGAffineTransformIdentity;
        } completion:nil];
    }
    
}

//拖动自身
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event{
    CGPoint p = [[touches anyObject]locationInView:nil];
    _isTouchedMenu = CGRectContainsPoint(self.frame, p);
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint p = [[touches anyObject]locationInView:nil];
    if (_isTouchedMenu) {
        [self changeFrameWithPoint:p];
    }
}

@end
