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

extension NSScreen {
  func createOverlayWindow() -> NSWindow {
    let window = NSWindow(
      contentRect: NSRect(
        x: 0,
        y: 0,
        width: frame.size.width,
        height: frame.size.height
      ),
      styleMask: .borderless,
      backing: .buffered,
      defer: false,
      screen: self
    )

    window.backgroundColor = .black
    window.canHide = false
    window.collectionBehavior = [
      .canJoinAllSpaces,
      .stationary,
      .ignoresCycle,
      .fullScreenAuxiliary
    ]
    window.level = .screenSaver + 1
    window.ignoresMouseEvents = true

    return window
  }
}
