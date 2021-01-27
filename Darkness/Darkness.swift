// Copyright 2021 Matt Beshara.
//
// This file is part of Darkness.
//
// Darkness is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Darkness is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Darkness.  If not, see <https://www.gnu.org/licenses/>.

import Cocoa

class Darkness {
  let alphaKey: String = "alpha"
  let delta: CGFloat = 1 / 16

  var windows: [NSWindow] = []
  var defaults: UserDefaults = UserDefaults.standard

  var darkness: CGFloat {
    get { CGFloat(max(0, min(1, defaults.float(forKey: alphaKey)))) }
    set { defaults.setValue(newValue, forKey: alphaKey) }
  }

  lazy var keyEventListener =
    EventFilter(1 << CGEventType.keyDown.rawValue) {
      switch $0.getIntegerValueField(.keyboardEventKeycode) {
      case 122: // F1
        self.modifyDarkness { $0 + self.delta }
        return nil
      case 120: // F2
        self.modifyDarkness { $0 - self.delta }
        return nil
      default:
        return $0
      }
  }

  init() {
    registerDefaults()
    windows = NSScreen.screens.map { $0.createOverlayWindow() }
    windows.forEach {
      $0.alphaValue = darkness
      $0.orderFrontRegardless()
    }
    keyEventListener.run()
  }

  func modifyDarkness(_ modifier: (CGFloat) -> CGFloat) {
    darkness = modifier(darkness)
    windows.forEach { $0.animator().alphaValue = darkness }
  }

  func registerDefaults() {
    defaults.register(defaults: [alphaKey: delta])
  }
}
