// swift-tools-version: 6.0

import PackageDescription

let lint = Target.PluginUsage.plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")
let libs: [Target] = [
  .target(name: "Extensions", path: "Source")
]

let package = Package(
  name: "Extensions",
  platforms: [.iOS(.v16), .macOS(.v12)],
  products: libs.map { .library(name: $0.name, targets: [$0.name]) },
  dependencies: [
    .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", from: "0.1.0")
  ],
  targets: libs + [
    .testTarget(
      name: "ExtensionsTest", dependencies: libs.map { .byName(name: $0.name) }, path: "Test", plugins: [lint]
    )
  ]
)
