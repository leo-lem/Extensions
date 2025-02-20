// Created by Leopold Lemmermann on 20.02.25.

@freestanding(declaration)
public macro Database<T>() = #externalMacro(module: "ExtensionsMacros", type: "DatabaseMacro")
