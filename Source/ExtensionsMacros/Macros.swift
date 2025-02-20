// Created by Leopold Lemmermann on 20.02.25.

import SwiftSyntaxMacros
import SwiftCompilerPlugin

@main
struct Macros: CompilerPlugin {
  var providingMacros: [Macro.Type] = [DatabaseMacro.self]
}
