// Created by Leopold Lemmermann on 15.12.22.

import SwiftUI

@available(iOS 14, macOS 11, tvOS 14, watchOS 7, *)
@propertyWrapper
public struct ObjectSceneStorage<T: Codable>: DynamicProperty {
  public var wrappedValue: T {
    get { (try? decoder.decode(T.self, from: data)) ?? initialValue }
    nonmutating set { data ?= (try? encoder.encode(newValue)) }
  }

  public var projectedValue: Binding<T> {
    Binding { wrappedValue } set: { wrappedValue = $0 }
  }

  @SceneStorage var data: Data
  private let encoder = JSONEncoder(),
              decoder = JSONDecoder()
  private let initialValue: T

  public init<S: StringProtocol>(wrappedValue: T, _ key: S) {
    initialValue = wrappedValue
    _data = SceneStorage(wrappedValue: (try? encoder.encode(wrappedValue)) ?? Data(), key.description)
  }
}
