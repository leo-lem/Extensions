// Created by Leopold Lemmermann on 20.02.25.

import SwiftSyntax
import SwiftSyntaxMacros

public struct DatabaseMacro: DeclarationMacro {
  public static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    print(node.arguments)
    print(node.genericArgumentClause!)
    print(context)
    let type = "Project"
    return [
      """
      extension DependencyValues {
        var \(raw: type.lowercased())s: Database<\(raw: type)> {
        get { self[Database<\(raw: type)>.self] }
        set { self[Database<\(raw: type)>.self] = newValue }
        }
      }
      """
    ]
  }
}
