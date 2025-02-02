import Foundation

public extension Bundle {
  subscript (string key: String) -> String {
    let value = object(forInfoDictionaryKey: key) as? String
    assert(value != nil, "Missing Info.plist key \(key)")
    return value ?? ""
  }
}

public extension FileManager {
  static func container_url(group: String) -> URL {
    let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: group)
    assert(url != nil, "Couldn't find container for \(group)")
    return url ?? URL(fileURLWithPath: "/dev/null")
  }

  static func document_url(_ name: String) -> URL {
    try! FileManager.default
      .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
      .appending(component: name)
      .appendingPathExtension(for: .json)
  }
}

public extension Locale {
  static var language_code: Locale.LanguageCode { Locale.current.language.languageCode ?? .english }
}
