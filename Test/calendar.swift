// Created by Leopold Lemmermann on 28.04.23.

@testable import Extensions
import Foundation
import Testing

struct CalendarTest {
  private var cal: Calendar {
    var cal = Calendar(identifier: .iso8601)
    cal.timeZone = .gmt
    return cal
  }
  private let date = Date(timeIntervalSinceReferenceDate: 9_999_999)

  @Test(arguments: [
    (Calendar.Component.day, 9_936_000),
    (.weekOfYear, 9_676_800),
    (.month, 7_776_000),
    (.year, 0)
  ])
  func givenAValidComponent_whenGettingStartOf_thenReturnsDate(parameter: (Calendar.Component, TimeInterval)) {
    #expect(cal.start(of: parameter.0, for: date) == Date(timeIntervalSinceReferenceDate: parameter.1))
  }

  @Test(arguments: [Calendar.Component.calendar, .weekdayOrdinal])
  func givenAnInvalidComponent_whenGettingStartOf_thenReturnsNil(component: Calendar.Component) {
    #expect(cal.start(of: component, for: date) == nil)
  }

  @Test(arguments: [
    (Calendar.Component.day, 10_022_399),
    (.weekOfYear, 10_281_599),
    (.month, 10_367_999),
    (.year, 31_535_999)
  ])
  func givenAValidComponent_whenGettingEndOf_thenReturnsDate(parameter: (Calendar.Component, TimeInterval)) {
    #expect(cal.end(of: parameter.0, for: date) == Date(timeIntervalSinceReferenceDate: parameter.1))
  }

  @Test(arguments: [Calendar.Component.calendar, .weekdayOrdinal])
  func givenAnInvalidComponent_whenGettingEndOf_thenReturnsNil(component: Calendar.Component) {
    #expect(cal.end(of: component, for: date) == nil)
  }
}
