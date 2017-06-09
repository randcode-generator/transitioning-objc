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

// MARK: Catalog by convention

extension FadeExampleViewController {
  class func catalogBreadcrumbs() -> [String] { return ["1. Fade transition"] }
}

extension FadeInteractiveExampleViewController {
  class func catalogBreadcrumbs() -> [String] { return ["1(i). Fade transition (2 way)"] }
}

extension FadeInteractiveExample1WayViewController {
  class func catalogBreadcrumbs() -> [String] { return ["2(i). Fade transition (1 way)"] }
}

extension CustomPresentationExampleViewController {
  class func catalogBreadcrumbs() -> [String] { return ["2. Custom presentation transitions"] }
}
