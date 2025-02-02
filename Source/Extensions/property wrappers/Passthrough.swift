//	Created by Leopold Lemmermann on 22.11.22.

import SwiftUI

@propertyWrapper
public struct Passthrough<T> {
  public var wrappedValue: T {
    get { base.wrappedValue }
    set { base.wrappedValue = newValue }
  }

  private let base: Binding<T>

  public init(_ base: Binding<T>) { self.base = base }
}
