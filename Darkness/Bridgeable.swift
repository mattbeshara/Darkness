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
