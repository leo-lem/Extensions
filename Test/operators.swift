// Created by Leopold Lemmermann on 29.04.23.

@testable import Extensions
import Testing

struct OperatorTests {
  @Test func whenAssigningOptionally_thenIsAssigned() {
    var value = 1
    let newValue: Int? = 2

    value ?= newValue

    #expect(value == 2)
  }

  @Test func whenAssigningNilOptionally_thenIsNotAssigned() {
    var value = 1
    let newValue: Int? = nil

    value ?= newValue

    #expect(value == 1)
  }
}
