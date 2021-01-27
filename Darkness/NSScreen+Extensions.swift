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
