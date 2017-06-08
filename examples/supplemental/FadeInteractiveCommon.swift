import Foundation
import Transitioning

@objc protocol FadeInteractiveCommon {
  func setInteractive(context: InteractiveTransitionContext)
  func initDraggable()
}
