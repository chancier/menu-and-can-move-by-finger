//
//  ViewController.m
//  TestSwip
//
//  Created by chen on 14-11-10.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "ViewController.h"
#import "RootVC.h"
/* */

@interface ViewController ()<UIGestureRecognizerDelegate>

@end

@implementation ViewController


- (IBAction)pushToRootVC:(id)sender
{
    RootVC *rootVC = [[RootVC alloc]initWithNibName:@"RootVC" bundle:nil];
    [self presentViewController:rootVC animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIPanGestureRecognizer * panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(doHandlePanAction:)];
    panGestureRecognizer.delegate = self;
    [self.testLab addGestureRecognizer:panGestureRecognizer];
    
//    [UIView animateWithDuration:0.5 animations:^{
//        
//        CGRect frame = self.testLab.frame;
//        frame.origin = CGPointMake(0, 0);
//        self.testLab.frame = frame;
//        
//        
//        CABasicAnimation* rotationAnimation;
//        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
//        rotationAnimation.duration = 1;
//        rotationAnimation.cumulative = YES;
//        rotationAnimation.repeatCount = YES;
//        rotationAnimation.fromValue = 0;
//        [self.testLab.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
//        
//    } completion:^(BOOL finished) {
//        
//    }];
    
    
}

- (void) viewDidAppear:(BOOL)paramAnimated{
    
    [super viewDidAppear:paramAnimated];
    self.testLab.center = self.view.center;
    
    /* Begin the animation */
    [UIView beginAnimations:@"clockwiseAnimation" context:NULL];
    /* Make the animation 5 seconds long */
    [UIView setAnimationDuration:1.0f];
    [UIView setAnimationDelegate:self];
    //停止动画时候调用clockwiseRotationStopped方法
    [UIView setAnimationDidStopSelector:@selector(clockwiseRotationStopped:finished:context:)];
    //顺时针旋转90度
    self.testLab.transform = CGAffineTransformMakeRotation((90.0f * M_PI) / 180.0f);
    /* Commit the animation */
    [UIView commitAnimations];
}

- (void)clockwiseRotationStopped:(NSString *)paramAnimationID finished:(NSNumber *)paramFinished
                         context:(void *)paramContext{
    [UIView beginAnimations:@"counterclockwiseAnimation"context:NULL];
    /* 5 seconds long */
    [UIView setAnimationDuration:1.0f];
    /* 回到原始旋转 */
    self.testLab.transform = CGAffineTransformIdentity;
    [UIView commitAnimations];
}

- (void)startAnimation
{
//    CGAffineTransform endAngle = CGAffineTransformMakeRotation(imageviewAngle * (M_PI / 180.0f));
//    
//    [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
//        imageView.transform = endAngle;
//    } completion:^(BOOL finished) {
//        angle += 10;
//        [self startAnimation];
//    }];
    
}

- (void)doHandlePanAction:(UIPanGestureRecognizer *)gestureRecognizer
{
    
    UIView *view = [gestureRecognizer view]; // 这个view是手势所属的view，也就是增加手势的那个view
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:{
            NSLog(@"======UIGestureRecognizerStateBegan");
            break;
        }
        case UIGestureRecognizerStateChanged:{
            NSLog(@"======UIGestureRecognizerStateChanged");
            
            /*
             让view跟着手指移动
             
             1.获取每次系统捕获到的手指移动的偏移量translation
             2.根据偏移量translation算出当前view应该出现的位置
             3.设置view的新frame
             4.将translation重置为0（十分重要。否则translation每次都会叠加，很快你的view就会移除屏幕！）
             */
            
            CGPoint translation = [gestureRecognizer translationInView:self.view];
            view.center = CGPointMake(gestureRecognizer.view.center.x + translation.x, gestureRecognizer.view.center.y + translation.y);
            [gestureRecognizer setTranslation:CGPointMake(0, 0) inView:self.view];//  注意一旦你完成上述的移动，将translation重置为0十分重要。否则translation每次都会叠加，很快你的view就会移除屏幕！
            break;
        }
        case UIGestureRecognizerStateCancelled:{
            NSLog(@"======UIGestureRecognizerStateCancelled");
            break;
        }
        case UIGestureRecognizerStateFailed:{
            NSLog(@"======UIGestureRecognizerStateFailed");
            break;
        }
        case UIGestureRecognizerStatePossible:{
            NSLog(@"======UIGestureRecognizerStatePossible");
            break;
        }
        case UIGestureRecognizerStateEnded:{ // UIGestureRecognizerStateRecognized = UIGestureRecognizerStateEnded
            
            /*
             当手势结束后，view的减速缓冲效果
             
             模拟减速写的一个很简单的方法。它遵循如下策略：
             计算速度向量的长度（i.e. magnitude）
             如果长度小于200，则减少基本速度，否则增加它。
             基于速度和滑动因子计算终点
             确定终点在视图边界内
             让视图使用动画到达最终的静止点
             使用“Ease out“动画参数，使运动速度随着时间降低
             */
            
            NSLog(@"======UIGestureRecognizerStateEnded || UIGestureRecognizerStateRecognized");
            
            CGPoint velocity = [gestureRecognizer velocityInView:self.view];// 分别得出x，y轴方向的速度向量长度（velocity代表按照当前速度，每秒可移动的像素个数，分xy轴两个方向）
            CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));// 根据直角三角形的算法算出综合速度向量长度
            
            // 如果长度小于200，则减少基本速度，否则增加它。
            CGFloat slideMult = magnitude / 200;
            
            NSLog(@"magnitude: %f, slideMult: %f", magnitude, slideMult);
            float slideFactor = 0.1 * slideMult; // Increase for more of a slide
            
            // 基于速度和滑动因子计算终点
            CGPoint finalPoint = CGPointMake(view.center.x + (velocity.x * slideFactor),
                                             view.center.y + (velocity.y * slideFactor));
            
            // 确定终点在视图边界内
            finalPoint.x = MIN(MAX(finalPoint.x, 0), self.view.bounds.size.width);
            finalPoint.y = MIN(MAX(finalPoint.y, 0), self.view.bounds.size.height);
            
            [UIView animateWithDuration:slideFactor*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                view.center = finalPoint;
            } completion:nil];
            
            break;
        }
        default:{
            NSLog(@"======Unknow gestureRecognizer");
            break;
        }
    }
    
    
    /*
     无动画效果
     */
//    CGPoint offset = [gestureRecognizer translationInView:self.view];
//    gestureRecognizer.view.center = CGPointMake(gestureRecognizer.view.center.x + offset.x, gestureRecognizer.view.center.y + offset.y);
//    [gestureRecognizer setTranslation:CGPointMake(0, 0) inView:self.view];
}


- (void)test
{
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(testS:)];
    [self.testLab addGestureRecognizer:gesture];
}

- (void)testS:(UIPanGestureRecognizer*)gesture
{
    CGPoint offset = [gesture translationInView:self.view];
    gesture.view.center = CGPointMake(gesture.view.center.x + offset.x, gesture.view.center.y);
    [gesture setTranslation:CGPointMake(0, 0) inView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
