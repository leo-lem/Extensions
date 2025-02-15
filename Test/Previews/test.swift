@testable import Previews
import Testing

struct PreviewsTest {
  @Test func randomStringHasNumberOfChars() {
    #expect(String.random(count: 10).count == 10)
  }

  @Test(arguments: [" ", ".", "/", "\n"])
  func randomStringContainsNoUndefinedChars(char: Character) {
    #expect(!String.random(count: 10, using: .alphanumerics).contains(char))
  }
}
