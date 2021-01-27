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
import CoreGraphics

extension EventFilter: Bridgeable {}

public class EventFilter {
  let mask: CGEventMask
  let handler: (CGEvent) -> CGEvent?

  init(_ mask: CGEventMask, handler: @escaping (CGEvent) -> CGEvent?) {
    self.mask = mask
    self.handler = handler
  }

  private let callback: CGEventTapCallBack = {
    (_, _, event: CGEvent, userInfo: UnsafeMutableRawPointer?)
    -> Unmanaged<CGEvent>? in
    guard let eventFilter = userInfo.flatMap(EventFilter.bridge) else {
      return Unmanaged.passUnretained(event)
    }
    return eventFilter.handler(event).map(Unmanaged.passUnretained)
  }

  private lazy var tap: CFMachPort? = CGEvent.tapCreate(
    tap: .cgSessionEventTap,
    place: .headInsertEventTap,
    options: .defaultTap,
    eventsOfInterest: mask,
    callback: callback,
    userInfo: bridge())

  func run() {
    guard let tap = tap else {
      let alert = NSAlert()
      alert.alertStyle = .critical
      alert.messageText = "Event tap creation failed."
      alert.informativeText = "Ensure Darkness has correct permissions."
      alert.addButton(withTitle: "Quit")
      alert.runModal()
      exit(0)
    }
    CFRunLoopAddSource(
      CFRunLoopGetCurrent(),
      CFMachPortCreateRunLoopSource(nil, tap, 0),
      .commonModes)
  }
}
