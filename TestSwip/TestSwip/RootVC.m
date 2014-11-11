//
//  RootVC.m
//  TestSwip
//
//  Created by chen on 14-11-11.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "RootVC.h"
#import "BounceViewController.h"

@interface RootVC ()

@end

@implementation RootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.menuButton initAnimationWithFadeEffectEnabled:YES];
    
    UIPanGestureRecognizer * panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(doHandlePanAction:)];
    [self.menuButton addGestureRecognizer:panGestureRecognizer];
    
    BounceViewController *bounceVC = [[BounceViewController alloc]initWithNibName:@"BounceViewController" bundle:nil];
    
    self.menuItemView = (BounceButtonView *)bounceVC.view;
    
    NSArray *arrMenuItemButtons = [[NSArray alloc] initWithObjects:self.menuItemView.menuItem1,
                                   self.menuItemView.menuItem2,
                                   nil]; // Add all of the defined 'menu item button' to 'menu item view'
    [self.menuItemView addBounceButtons:arrMenuItemButtons];
    
    // Set the bouncing distance, speed and fade-out effect duration here. Refer to the ASOBounceButtonView public properties
    [self.menuItemView setBouncingDistance:[NSNumber numberWithFloat:0.7f]];
    
    // Set as delegate of 'menu item view'
    [self.menuItemView setDelegate:self];
}

- (void)doHandlePanAction:(UIPanGestureRecognizer *)sender
{
    CGPoint offset = [sender translationInView:self.view];
    sender.view.center = CGPointMake(sender.view.center.x + offset.x, sender.view.center.y + offset.y);
    [sender setTranslation:CGPointMake(0, 0) inView:self.view];
    
}


- (void)viewDidAppear:(BOOL)animated
{
    // Tell 'menu button' position to 'menu item view'
    [self.menuItemView setAnimationStartFromHere:self.menuButton.frame];
}

- (IBAction)menuButtonAction:(id)sender
{
    if ([sender isOn]) {
        // Show 'menu item view' and expand its 'menu item button'
        [self.menuButton addCustomView:self.menuItemView];
        [self.menuItemView expandWithAnimationStyle:ASOAnimationStyleExpand];
    }
    else {
        // Collapse all 'menu item button' and remove 'menu item view'
        [self.menuItemView collapseWithAnimationStyle:ASOAnimationStyleExpand];
        [self.menuButton removeCustomView:self.menuItemView interval:[self.menuItemView.collapsedViewDuration doubleValue]];
    }
}

#pragma mark - Menu item view delegate method

- (void)didSelectBounceButtonAtIndex:(NSUInteger)index
{
    // Collapse all 'menu item button' and remove 'menu item view' once a menu item is selected
    [self.menuButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    // Set your custom action for each selected 'menu item button' here
    NSString *alertViewTitle = [NSString stringWithFormat:@"Menu Item %x is selected", (short)index];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertViewTitle message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

- (void)willAnimateRotationToInterfaceOrientation:
(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration
{
    // Update 'menu button' position to 'menu item view' everytime there is a change in device orientation
    [self.menuItemView setAnimationStartFromHere:self.menuButton.frame];
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
