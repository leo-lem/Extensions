//	Created by Leopold Lemmermann on 05.12.22.

import Foundation

@propertyWrapper
public struct Saved<Value: Codable> {
  private let url: URL

  public var wrappedValue: Value {
    didSet {
      try? JSONEncoder().encode(wrappedValue).write(to: url, options: .atomic)
    }
  }

  public init(wrappedValue: Value, _ key: String) {
    url = FileManager.default
      .urls(for: .documentDirectory, in: .userDomainMask)[0]
      .appendingPathComponent("\(key).json")

    self.wrappedValue = (try? JSONDecoder().decode(Value.self, from: try Data(contentsOf: url))) ?? wrappedValue
  }
}
