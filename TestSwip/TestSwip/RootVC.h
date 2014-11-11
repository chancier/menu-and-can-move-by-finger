//
//  RootVC.h
//  TestSwip
//
//  Created by chen on 14-11-11.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASOTwoStateButton.h"
#import "ASOBounceButtonViewDelegate.h"
#import "BounceButtonView.h"

@interface RootVC : UIViewController<ASOBounceButtonViewDelegate>

@property (strong, nonatomic) IBOutlet ASOTwoStateButton *menuButton;
@property (strong, nonatomic) BounceButtonView *menuItemView;

- (IBAction)menuButtonAction:(id)sender;


@end
