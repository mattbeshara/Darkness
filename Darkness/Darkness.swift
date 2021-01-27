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
    windows = NSScreen.screens.map(createWindow)
    windows.forEach { $0.orderFrontRegardless() }
    keyEventListener.run()
  }

  func modifyDarkness(_ modifier: (CGFloat) -> CGFloat) {
    darkness = modifier(darkness)
    windows.forEach { $0.animator().alphaValue = darkness }
  }

  func registerDefaults() {
    defaults.register(defaults: [alphaKey: delta])
  }

  func createWindow(screen: NSScreen) -> NSWindow {
    let window = NSWindow(
      contentRect: NSRect(
        x: 0,
        y: 0,
        width: screen.frame.size.width,
        height: screen.frame.size.height
      ),
      styleMask: .borderless,
      backing: .buffered,
      defer: false,
      screen: screen
    )

    window.alphaValue = darkness
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
