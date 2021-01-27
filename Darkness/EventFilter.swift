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
    guard let tap = tap else { fatalError("Failed to create tap") }
    CFRunLoopAddSource(
      CFRunLoopGetCurrent(),
      CFMachPortCreateRunLoopSource(nil, tap, 0),
      .commonModes)
  }
}
