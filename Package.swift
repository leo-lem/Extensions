// swift-tools-version: 5.8

import PackageDescription

let lint = Target.PluginUsage.plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")
let libs: [Target] = [
  .target(name: "Concurrency"),
  .target(name: "Errors"),
  .target(name: "Previews"),
  .target(name: "Queries"),
  .target(name: "Extensions", dependencies: ["Previews"]),
]

let package = Package(
  name: "Extensions",
  platforms: [.iOS(.v16), .macOS(.v12)],
  products: libs.map { .library(name: $0.name, targets: [$0.name]) },
  dependencies: [
    .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", from: "0.1.0"),
  ],
  targets: libs + libs.map {
    .testTarget(name: "\($0.name)Test", dependencies: [.byName(name: $0.name)], path: "Test/\($0.name)", plugins: [lint])
  }
)
