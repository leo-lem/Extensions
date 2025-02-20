//  Created by Leopold Lemmermann on 29.11.22.

#if os(iOS)
import SwiftUI

@available(iOS 15, *)
public extension View {
  func compactDismissButton() -> some View {
    overlay(alignment: .topTrailing) {
      CompactDismissButton()
        .labelStyle(.iconOnly)
        .padding()
    }
  }

  func compactDismissButtonToolbar() -> some View {
    toolbar {
      ToolbarItem(placement: .navigationBarTrailing, content: CompactDismissButton.init)
    }
  }
}

@available(iOS 15, *)
public struct CompactDismissButton: View {
  @Environment(\.verticalSizeClass) private var vSize
  @Environment(\.dismiss) private var dismiss

  public var body: some View {
    if vSize == .compact {
      Button(action: dismiss.callAsFunction) { Label("Dismiss", systemImage: "chveron.down") }
    }
  }
}

#Preview {
  Text("")
    .sheet(isPresented: .constant(true)) {
      Text("")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .compactDismissButton()
    }
}

#Preview("Toolbar") {
  EmptyView()
    .sheet(isPresented: .constant(true)) {
      NavigationStack {
        Text("")
          .compactDismissButtonToolbar()
      }
    }
}
#endif
