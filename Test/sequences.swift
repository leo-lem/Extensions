// Created by Leopold Lemmermann on 18.02.2025.

@testable import Extensions
import Foundation
import Testing

struct SequenceTests {
  struct Dummy: Identifiable, Hashable {
    var id = UUID()
    var value = Int.random(in: 0..<10)
  }

  let id = UUID()

  @Test func removingDuplicateStrings() async throws {
    let strings = ["Hello", "there", "Hello", "there"]
    #expect(strings.removingDuplicates() == ["Hello", "there"])
  }

  @Test func removingDuplicatesByKeyPath() async throws {
    let dummies: [Dummy] = [Dummy(id: id, value: 0), Dummy(id: id, value: 10), Dummy()]
    #expect(dummies.removingDuplicates(by: \.id).count == 2)
  }

  @Test func creatingIdentifiableSet() async throws {
    let dummies: IdentifiableSet = [Dummy(id: id, value: 0), Dummy(id: id, value: 1), Dummy()]
    #expect(dummies.count == 2)
  }

  @Test func addingToIdentifiableSet() async throws {
    var dummies: IdentifiableSet = [Dummy(id: id, value: 0)]
    dummies.insert(Dummy(id: id, value: 1))
    dummies.insert(Dummy())
    #expect(dummies.count == 2)
  }

  @Test func updatingIdentifiableSet() async throws {
    var dummies: IdentifiableSet = [Dummy(id: id, value: 0), Dummy()]
    dummies.update(with: Dummy(id: id, value: 1))
    #expect(dummies[id]?.value == 1)
  }
}
