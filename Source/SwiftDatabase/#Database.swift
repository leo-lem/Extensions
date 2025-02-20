// Created by Leopold Lemmermann on 20.02.25.

/// This is on hold until macros can declare extensions.
@freestanding(declaration)
public macro Database<T>() = #externalMacro(module: "ExtensionsMacros", type: "DatabaseMacro")
