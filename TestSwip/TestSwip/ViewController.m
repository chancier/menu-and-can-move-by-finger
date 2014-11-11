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

@interface ViewController ()

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

- (void)doHandlePanAction:(UIPanGestureRecognizer *)sender
{
    CGPoint offset = [sender translationInView:self.view];
    sender.view.center = CGPointMake(sender.view.center.x + offset.x, sender.view.center.y + offset.y);
    [sender setTranslation:CGPointMake(0, 0) inView:self.view];
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
