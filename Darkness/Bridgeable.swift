public protocol Bridgeable: AnyObject {
  static func bridge(_: UnsafeMutableRawPointer) -> Self?
  func bridge() -> UnsafeMutableRawPointer
}

public extension Bridgeable {
  static func bridge(_ pointer: UnsafeMutableRawPointer) -> Self? {
    Unmanaged.fromOpaque(pointer).takeUnretainedValue()
  }

  func bridge() -> UnsafeMutableRawPointer {
    UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque())
  }
}
