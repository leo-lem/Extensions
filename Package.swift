// swift-tools-version: 6.0

import PackageDescription
import CompilerPluginSupport

let deps = Target.Dependency.product(name: "Dependencies", package: "swift-dependencies")
let lint = Target.PluginUsage.plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")
let libs: [Target] = [
  .target(name: "Extensions"),
  .target(name: "SwiftUIExtensions", dependencies: ["Extensions"])
]

let package = Package(
  name: "Extensions",
  platforms: [.iOS(.v17), .macOS(.v13)],
  products: libs.map { .library(name: $0.name, targets: [$0.name]) },
  dependencies: [
//    .package(url: "https://github.com/pointfreeco/swift-dependencies.git", from: "1.0.0"),
    .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", from: "0.1.0"),
    .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "600.0.0")
  ],
  targets: libs + [
    .testTarget(
      name: "ExtensionsTest", dependencies: libs.map { .byName(name: $0.name) }, path: "Test", plugins: [lint]
    ),
    .macro(
      name: "ExtensionsMacros",
      dependencies: [
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
      ]
    )
  ]
)
