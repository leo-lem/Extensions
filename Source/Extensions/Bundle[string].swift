import Foundation

public extension Bundle {
  subscript(string key: String) -> String {
    let value = object(forInfoDictionaryKey: key) as? String
    assert(value != nil, "Missing Info.plist key \(key)")
    return value ?? key
  }

  subscript(url key: String) -> URL {
    let url = URL(string: self[string: key])
    assert(url != nil, "Invalid URL \(key)")
    return url ?? URL(fileURLWithPath: "/dev/null")
  }
}
