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
  
  func isInteractive(_ context: TransitionContext) -> Bool {
    if(isTwoWay) {
      return true
    } else {
      if(context.direction == .forward) {
        return true
      } else {
        return false
      }
    }
  }
  
  func start(withInteractiveContext context: InteractiveTransitionContext) {
    
    if (context.transitionContext.direction == .forward) {
      let m = context.transitionContext.foreViewController as! ModalInteractiveViewController
      m.setcontext(context: context)
    } else {
      let n = context.transitionContext.sourceViewController as! FadeInteractiveCommon
      n.setInteractive(context: context)
      n.initDraggable()
    }
  }
}
