// Created by Leopold Lemmermann on 25.07.25.

import SwiftUI

/// Like NavigationLink, but with a sheet.
///
/// !!!: does not work inside of Menu.
public struct SheetLink<L: View, D: View>: View {
  public let label: () -> L
  public let destination: () -> D

  @State private var showingSheet = false

  public var body: some View {
//    Toggle(isOn: $showingSheet, label: label)
    Button(action: { showingSheet.toggle() }, label: label)
      .toggleStyle(.button)
      .sheet(isPresented: $showingSheet, content: destination)
  }

  public init(
    @ViewBuilder destination: @escaping () -> D,
    @ViewBuilder label: @escaping () -> L
  ) {
    self.label = label
    self.destination =  destination
  }

  public init(
    _ titleKey: LocalizedStringKey,
    @ViewBuilder destination: @escaping () -> D
  ) where L == Text {
    self.label = { Text(titleKey) }
    self.destination = destination
  }
}

#Preview {
  SheetLink {
    Text("This is your sheet content.")
  } label: {
    Text("Open Sheet")
  }
}
