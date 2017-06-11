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

import UIKit
import Transitioning

final class FadeInteractiveTransition: NSObject, InteractiveTransition {
  var isTwoWay = true
  var context:InteractiveTransitionContext! = nil
  
  func isInteractive(_ context: TransitionContext) -> Bool {
    if(isTwoWay) {
      return true
    } else {
      if(context.direction == .forward) {
        return false
      } else {
        return true
      }
    }
  }
  
  func start(withInteractiveContext context: InteractiveTransitionContext) {
    self.context = context
    
    if (context.transitionContext.direction == .forward) {
      let m = context.transitionContext.foreViewController as! ModalInteractiveViewController
      m.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(didPan)))
    } else {
      let n = context.transitionContext.backViewController
      n.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(didPan)))
      prevY = 0
      percentage = CGFloat(0.01)
    }
  }
  
  var prevY: CGFloat = 0
  var percentage = CGFloat(0.01)
  func didPan(_ gestureRecognizer : UIPanGestureRecognizer) {
    let translation = gestureRecognizer.location(in: gestureRecognizer.view)
    
    if(context.transitionContext.direction == .forward) {
      if prevY > translation.y {
        percentage += 0.05
      } else {
        percentage -= 0.05
      }
    } else {
      if prevY > translation.y {
        percentage -= 0.05
      } else {
        percentage += 0.05
      }
    }
    
    if(gestureRecognizer.state == .began) {
      context.transitionContext.foreViewController.dismiss(animated: true, completion: nil)
    } else if(gestureRecognizer.state == .changed) {
      prevY = translation.y
      context.updatePercent(percentage)
    } else if(gestureRecognizer.state == .ended) {
      if percentage > 0.5 {
        context.finishInteractiveTransition()
      } else {
        context.cancelInteractiveTransition()
      }
      percentage = CGFloat(0.01)
    }
  }
}
