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

// This example demonstrates the minimal path to building a custom transition using the Material
// Motion Transitioning APIs in Swift. The essential steps have been documented below.

class FadeInteractiveExampleViewController2: ExampleViewController {

  var context: InteractiveTransitionContext! = nil
  func setcontext(context: InteractiveTransitionContext) {
    self.context = context
  }

  func initDraggable() {
    view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(didPan)))

    percentage = CGFloat(0.01)
    prevY = 0
  }

  func didTap() {
    let modalViewController = ModalInteractiveViewController()

    modalViewController.shouldShowText = false
    // The transition controller is an associated object on all UIViewController instances that
    // allows you to customize the way the view controller is presented. The primary API on the
    // controller that you'll make use of is the `transition` property. Setting this property will
    // dictate how the view controller is presented. For this example we've built a custom
    // FadeTransition, so we'll make use of that now:
    modalViewController.transitionController.transition = FadeTransitionWithInteraction2()
    modalViewController.transitionController.interactiveTransition =
        FadeInteractionTransition2()

    // Note that once we assign the transition object to the view controller, the transition will
    // govern all subsequent presentations and dismissals of that view controller instance. If we
    // want to use a different transition (e.g. to use an edge-swipe-to-dismiss transition) then we
    // can simply change the transition object before initiating the transition.

    present(modalViewController, animated: true)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    let button = UIButton(frame: CGRect(x: 30, y: 250, width: 200, height: 50))
    button.backgroundColor = UIColor.green
    button.setTitle("start", for: .normal)
    button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
    view.addSubview(button)

    let label = UILabel(frame: CGRect(x: 30, y: 310, width: 300, height: 50))
    label.textColor = UIColor.white
    label.text = "Swipe up after pressing start"
    view.addSubview(label)
  }

  var prevY: CGFloat = 0
  var percentage = CGFloat(0.01)
  func didPan(_ gestureRecognizer : UIPanGestureRecognizer) {
    let translation = gestureRecognizer.location(in: gestureRecognizer.view)

    if prevY > translation.y {
      percentage -= 0.2
    } else {
      percentage += 0.2
    }

    if(percentage < 0) {
      percentage = 0
    }

    prevY = translation.y
    context.updatePercent(percentage)
    if percentage > 1.0 {
      context.finishInteractiveTransition()
    }
  }

  override func exampleInformation() -> ExampleInfo {
    return .init(title: type(of: self).catalogBreadcrumbs().last!,
                 instructions: "Tap to present a modal transition.")
  }
}

// Transitions must be NSObject types that conform to the Transition protocol.
private final class FadeTransitionWithInteraction2: NSObject, Transition {

  // The sole method we're expected to implement, start is invoked each time the view controller is
  // presented or dismissed.
  func start(with context: TransitionContext) {
    CATransaction.begin()

    CATransaction.setCompletionBlock {
      // Let UIKit know that the transition has come to an end.
      context.transitionDidEnd()
    }

    let fade = CABasicAnimation(keyPath: "opacity")

    fade.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

    // Define our animation assuming that we're going forward (presenting)...
    fade.fromValue = 0
    fade.toValue = 1

    // ...and reverse it if we're going backwards (dismissing).
    if context.direction == .backward {
      let swap = fade.fromValue
      fade.fromValue = fade.toValue
      fade.toValue = swap
    }

    // Add the animation...
    context.foreViewController.view.layer.add(fade, forKey: fade.keyPath)

    // ...and ensure that our model layer reflects the final value.
    context.foreViewController.view.layer.setValue(fade.toValue, forKeyPath: fade.keyPath!)

    CATransaction.commit()
  }
}

private final class FadeInteractionTransition2: NSObject, InteractiveTransition {
  func isInteractive(_ context: TransitionContext) -> Bool {
    if(context.direction == .forward) {
      return true
    } else {
      return false
    }
  }
  
  func start(withInteractiveContext context: InteractiveTransitionContext) {

    if (context.transitionContext.direction == .forward) {
      let m = context.transitionContext.foreViewController as! ModalInteractiveViewController
      m.setcontext(context: context)
    } else {
      let n = context.transitionContext.sourceViewController as! FadeInteractiveExampleViewController2
      n.setcontext(context: context)
      n.initDraggable()
    }
  }
}
