//
//  YUMenuOne.m
//  YUMenu
//
//  Created by administrator on 16/9/6.
//  Copyright © 2016年 xuanYuLin. All rights reserved.
//

#import "YUMenuOne.h"

#define AnimiationDuration 0.6  // 时间
#define delta 60    //按钮间的间距

@interface YUMenuOne ()

/** 存放按钮的数组 */
@property (strong, nonatomic) NSMutableArray *items;
/** 主按钮 */
@property (weak, nonatomic) UIImageView *MainMenu;

@end

@implementation YUMenuOne

- (NSMutableArray *)items
{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 创建主菜单
        [self createMainMenu];
        
        // 创建子按钮
        [self createItems];
        
        // 把主菜单置顶
        [self bringSubviewToFront:self.MainMenu];
    }
    return self;
}

/**
 *  创建主菜单
 */
- (void)createMainMenu
{
    UIImageView *MainMenu = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"small_main_menu"]];
    [self addSubview:MainMenu];
    
    self.MainMenu = MainMenu;

    // 添加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(MainMenuClick:)];
    [MainMenu addGestureRecognizer:tap];
    
    MainMenu.userInteractionEnabled = YES;
    // 主菜单
    self.MainMenu.frame = CGRectMake(0, 1, 48, 48);
}

/**
 *  创建所有子按钮
 */
- (void)createItems
{
    for (int i = 0; i < 4; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *imageName = [NSString stringWithFormat:@"icon_%d",i];
        [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [self.items addObject:btn];
        [self addSubview:btn];
        
        CGRect btnBounds = CGRectMake(0, 0, 43, 43);
        btn.bounds = btnBounds;
        btn.center = self.MainMenu.center;
    }
}


- (void)MainMenuClick:(UITapGestureRecognizer *)recognizer
{
    BOOL isShow = CGAffineTransformIsIdentity(self.MainMenu.transform);
    
    // 1.实现主菜单动画效果
    [UIView animateWithDuration:AnimiationDuration animations:^{
        if (isShow) {//代表transform未被改变
            self.MainMenu.transform =CGAffineTransformMakeRotation(M_PI_2);
        }else{//恢复
            self.MainMenu.transform =CGAffineTransformIdentity;
        }
        
    }];
    // 2.实现items动画效果
    [self showItems:isShow];
    
}

- (void)showItems:(BOOL)show
{
    // 实现 items 的 显示位置
    for (int i = 0; i < _items.count; i++) {
        UIButton *btn = _items[i];
        // 创建组组动画
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.duration = AnimiationDuration;
        
        // 添加一个 ”平移动画“
        CAKeyframeAnimation *positionAni = [CAKeyframeAnimation animation];
        positionAni.keyPath = @"position";
        
        // 添加一个 ”旋转的动画“
        CAKeyframeAnimation *rotationAni = [CAKeyframeAnimation animation];
        rotationAni.keyPath = @"transform.rotation";
        
        //重新设置每个按钮的x值
        CGFloat btnCenterX = self.MainMenu.center.x;
        CGFloat btnCenterY = self.MainMenu.center.y + (i + 1) * delta;
        
        // 最终显示的位置
        CGPoint showPosition = CGPointMake(btnCenterX, btnCenterY);
        
        //设置 "平移动画: 的 路径
        NSValue *value1 = [NSValue valueWithCGPoint:self.MainMenu.center];
        NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(btnCenterX, btnCenterY * 0.5)];
        NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(btnCenterX, btnCenterY * 1.1)];
        NSValue *value4 = [NSValue valueWithCGPoint:showPosition];
        positionAni.values = @[value1,value2,value3,value4];
        
        
        if (show) { //显示
            
            //设置 旋转的路径
            rotationAni.values = @[@0,@(M_PI * 2),@(M_PI * 4),@(M_PI * 2)];
            
            btn.center = showPosition;
        }else{ //隐藏
            
            //设置 "平移动画: 的 路径
            positionAni.values = @[value4,value3,value2,value1];
            
            btn.center = self.MainMenu.center;
            rotationAni.values = @[@0,@(M_PI * 2),@(0),@(-M_PI * 2)];
        }
        
        //添加子动画
        group.animations = @[positionAni,rotationAni];
        //执行组动画
        [btn.layer addAnimation:group forKey:nil];
    }
}


//拖动自身
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:nil];
    
    self.center = point;
}


@end
