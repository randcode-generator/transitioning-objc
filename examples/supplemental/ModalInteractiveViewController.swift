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
    let button = UIButton(frame: CGRect(x: 30, y: 100, width: 200, height: 50))
    button.backgroundColor = UIColor.green
    button.setTitle("Close", for: .normal)
    button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
    view.addSubview(button)

    if (shouldShowText) {
      let label = UILabel(frame: CGRect(x: 30, y: 160, width: 300, height: 50))
      label.textColor = UIColor.white
      label.text = "Swipe down after pressing close"
      view.addSubview(label)
    }
  }

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }

  func didTap() {
    dismiss(animated: true)
  }
}
