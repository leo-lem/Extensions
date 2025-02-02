//	Created by Leopold Lemmermann on 20.11.22.

import SwiftUI

@propertyWrapper
public struct Persisted<Value: Codable>: DynamicProperty {
  @State private var value: Value
  private let url: URL

  public var wrappedValue: Value {
    get { value }
    nonmutating set {
      value = newValue
      try? JSONEncoder().encode(wrappedValue).write(to: url, options: .atomic)
    }
  }
  
  public var projectedValue: Binding<Value> { Binding { wrappedValue } set: { wrappedValue = $0 } }

  public init(wrappedValue: Value, _ key: String) {
    url = FileManager.default
      .urls(for: .documentDirectory, in: .userDomainMask)[0]
      .appendingPathComponent("\(key).json")

    _value = State(
      initialValue: (try? JSONDecoder().decode(Value.self, from: try Data(contentsOf: url))) ?? wrappedValue
    )
    try? JSONEncoder().encode(value).write(to: url, options: .atomic)
  }
}
