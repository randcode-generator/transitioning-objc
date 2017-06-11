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

import Foundation
import UIKit
import Transitioning

class ModalInteractiveViewController: ExampleViewController {
  var shouldShowText = true

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .primaryColor

    if (shouldShowText) {
      let label = UILabel(frame: CGRect(x: 30, y: 160, width: 300, height: 50))
      label.textColor = UIColor.white
      label.text = "Swipe down after pressing close"
      view.addSubview(label)
    }
    
    view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(didPan)))
  }

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  var isCompleted: Bool = false
  var prevY: CGFloat = 0
  var percentage = CGFloat(0.01)
  func didPan(_ gestureRecognizer : UIPanGestureRecognizer) {
    let translation = gestureRecognizer.location(in: gestureRecognizer.view)
    
    if(interactiveTransitionContext!.transitionContext.direction == .forward) {
      if prevY > translation.y {
        percentage += 0.02
        percentage = min(percentage, 1)
      } else {
        percentage -= 0.02
        percentage = max(percentage, 0)
      }
    } else {
      if prevY < translation.y {
        percentage += 0.02
        percentage = min(percentage, 1)
      } else {
        percentage -= 0.02
        percentage = max(percentage, 0)
      }
    }
    
    prevY = translation.y
    if(gestureRecognizer.state == .began) {
      if(isCompleted) {
        dismiss(animated: true, completion: nil)
      }
    } else if(gestureRecognizer.state == .changed) {
      prevY = translation.y
      interactiveTransitionContext!.updatePercent(percentage)
    } else if(gestureRecognizer.state == .ended) {
      if percentage > 0.5 {
        interactiveTransitionContext!.finishInteractiveTransition()
        NSLog("finish")
      } else {
        interactiveTransitionContext!.cancelInteractiveTransition()
        NSLog("cancel")
      }
      isCompleted = true
      percentage = CGFloat(0.01)
    }
  }
}
