// Created by Leopold Lemmermann on 15.02.25.

@_exported import Dependencies
@_exported import SwiftData

/// For internal use. The ModelContainer has to be initialized, though.
@available(iOS 17, *)
public struct SwiftDatabase: Sendable {
  var context: @MainActor @Sendable () -> ModelContext
}

@available(iOS 17, *)
extension SwiftDatabase: DependencyKey {
  /// Configure the container using this static property.
  @MainActor public static var container: ModelContainer!
  @MainActor static let context = { ModelContext(container) }()
  
  public static let liveValue = SwiftDatabase(
    context: { Self.context }
  )
}

@available(iOS 17, *)
public extension DependencyValues {
  /// Interface to the SwiftData ModelContext.
  var data: SwiftDatabase {
    get { self[SwiftDatabase.self] }
    set { self[SwiftDatabase.self] = newValue }
  }
}
