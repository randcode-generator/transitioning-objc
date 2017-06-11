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

class FadeInteractiveExampleViewController: ExampleViewController {
  func didTap() {
    let modalViewController = ModalInteractiveViewController()

    // The transition controller is an associated object on all UIViewController instances that
    // allows you to customize the way the view controller is presented. The primary API on the
    // controller that you'll make use of is the `transition` property. Setting this property will
    // dictate how the view controller is presented. For this example we've built a custom
    // FadeTransition, so we'll make use of that now:
    modalViewController.transitionController.transition = FadeTransition()
    modalViewController.transitionController.interactiveTransition =
        FadeInteractiveTransition()

    // Note that once we assign the transition object to the view controller, the transition will
    // govern all subsequent presentations and dismissals of that view controller instance. If we
    // want to use a different transition (e.g. to use an edge-swipe-to-dismiss transition) then we
    // can simply change the transition object before initiating the transition.

    present(modalViewController, animated: true)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let label = UILabel(frame: CGRect(x: 30, y: 310, width: 300, height: 50))
    label.textColor = UIColor.white
    label.text = "Swipe up after pressing start"
    view.addSubview(label)
    
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
  }

  override func exampleInformation() -> ExampleInfo {
    return .init(title: type(of: self).catalogBreadcrumbs().last!,
                 instructions: "Tap to present a modal transition.")
  }
}
