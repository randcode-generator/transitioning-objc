/*
 Copyright 2017-present The Material Motion Authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "FadeInteractiveExample.h"

#import "TransitionsCatalog-Swift.h"

// This example demonstrates the minimal path to building a custom transition using the Material
// Motion Transitioning APIs in Objective-C. Please see the companion Swift implementation for
// detailed comments.

@implementation FadeInteractiveExampleObjcViewController {
  id<MDMInteractiveTransitionContext> transitionContext;
  CGFloat percentage;
  CGFloat prevY;
}

- (void)initDraggable {
  [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)]];
  percentage = 0.01;
  prevY = 0;
}

- (void)setInteractiveWithContext:(id <MDMInteractiveTransitionContext> _Nonnull)context {
  transitionContext = context;
}

- (void)didPan:(UIPanGestureRecognizer *)gestureRecognizer {
  CGPoint translation = [gestureRecognizer locationInView:gestureRecognizer.view];

  if (prevY > translation.y) {
    percentage -= 0.05;
  } else {
    percentage += 0.05;
  }

  if (percentage < 0) {
    percentage = 0;
  }

  prevY = translation.y;
  [transitionContext updatePercent:percentage];
  if (percentage > 1.0) {
    [transitionContext finishInteractiveTransition];
  }
}

- (void)didTap {
  ModalInteractiveViewController *viewController = [[ModalInteractiveViewController alloc] init];

  viewController.mdm_transitionController.transition = [[FadeTransition alloc] init];

  viewController.mdm_transitionController.interactiveTransition = [[FadeInteractiveTransition alloc] init];

  [self presentViewController:viewController animated:true completion:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor backgroundColor];

  UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(30, 250, 200, 50)];
  [button setBackgroundColor:[UIColor greenColor]];
  [button setTitle:@"start" forState:UIControlStateNormal];
  [button addTarget:self action:@selector(didTap) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];

  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 310, 300, 50)];
  [label setTextColor:[UIColor whiteColor]];
  [label setText:@"Swipe up after pressing start"];
  [self.view addSubview:label];
}

+ (NSArray<NSString *> *)catalogBreadcrumbs {
  return @[ @"1(i). Fade transition (objc) (2 way)" ];
}

@end
