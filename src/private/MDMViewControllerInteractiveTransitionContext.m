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

#import "MDMViewControllerInteractiveTransitionContext.h"
@interface percentdriven:UIPercentDrivenInteractiveTransition {
  id<MDMInteractiveTransition> IT;
  id<MDMInteractiveTransitionContext> context;
}
@end

@implementation percentdriven
- (nonnull instancetype)initWithContext:(nonnull id<MDMInteractiveTransition>)ITA c:(nonnull id<MDMInteractiveTransitionContext>)contextA{
  self = [super init];
  if (self) {
    IT = ITA;
    context = contextA;
  }
  return self;
}

- (void)startInteractiveTransition:(id <UIViewControllerContextTransitioning>)contextA {
  [super startInteractiveTransition:contextA];
  
  [IT startWithInteractiveContext: context];
}
@end

@implementation MDMViewControllerInteractiveTransitionContext {
  percentdriven *_percent;
}

@synthesize transitionContext = _transitionContext;

- (nonnull instancetype)initWithTransition:(nonnull id<MDMTransitionContext>)transitionContext it:(nonnull id<MDMInteractiveTransition>) IT {
  self = [super init];
  if (self) {
    _percent = [[percentdriven alloc] initWithContext: IT c:self];
    _transitionContext = transitionContext;
  }
  return self;
}

- (UIPercentDrivenInteractiveTransition *_Nonnull)getPercentIT {
  return _percent;
}

- (void)updatePercent:(CGFloat)percent {
  [_percent updateInteractiveTransition:percent];
}

- (void)finishInteractiveTransition {
  [_percent finishInteractiveTransition];
}

- (void)cancelInteractiveTransition {
  [_percent cancelInteractiveTransition];
}
@end
