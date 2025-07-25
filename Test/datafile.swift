// Created by Leopold Lemmermann on 29.04.23.

@testable import Extensions
import Foundation
import struct UniformTypeIdentifiers.UTType
import Testing

@Suite(.serialized) struct DataFileTests {
  let data = Data([1, 2, 3])
  let file = FileManager.default.temporaryDirectory.appending(path: "testfile")

  @Test func whenCreatingWithData_thenContentMatches() async throws {
    let file = DataFile(data)
    #expect(file.content == data)
  }

  @Test func givenValidDataAtURL_whenCreatingFromURL_thenCreatesFile() async throws {
    try data.write(to: file)
    #expect(try DataFile(at: file).content == data)
  }

  @Test func givenNoDataAtURL_whenCreatingFromURL_thenThrows() async throws {
    try? FileManager.default.removeItem(at: file)
    #expect(throws: Error.self) { try DataFile(at: file) }
  }
}
