// Created by Leopold Lemmermann on 11.02.25.

import SwiftUI

/// Label styling indicating an external link or action.
public struct ExternalLabelStyle: LabelStyle {
  public let color: Color,
             transfer: Bool

  public init(color: Color, transfer: Bool) {
    self.color = color
    self.transfer = transfer
  }

  public func makeBody(configuration: Configuration) -> some View {
    HStack {
      configuration.icon
        .foregroundStyle(iconColor)
        .frame(width: 35, height: 35)
        .background(color, in: .rect(cornerRadius: 5))
      configuration.title
      Spacer()
      Image(systemName: transfer ? "arrow.up.right" : "chevron.right")
    }
  }

  /// Icon color is white for darker colors and black for lighter color background.
  var iconColor: Color {
    let background = color.resolve(in: .init())
    return if background.blue < 0.8 || background.red < 0.8 || background.green < 0.8 {
      .white
    } else {
      .black
    }
  }
}

public extension LabelStyle where Self == ExternalLabelStyle {
  static func external(color: Color, transfer: Bool) -> Self {
    .init(color: color, transfer: transfer)
  }
}

#Preview {
  List {
    Button("Preview", systemImage: "document.fill") {}
      .labelStyle(ExternalLabelStyle(color: .red, transfer: false))
  }

  Button("Preview", systemImage: "lock") {}
    .labelStyle(ExternalLabelStyle(color: .white, transfer: true))
    .buttonStyle(.borderedProminent)
    .padding()
}
