// Created by Leopold Lemmermann on 31.03.23.

#if os(iOS)
import SwiftUI

//public struct WhiteboardTabViewStyle: TabViewStyle {
//  public static func _makeView<SelectionValue>(
//    value: _GraphValue<_TabViewValue<WhiteboardTabViewStyle, SelectionValue>>,
//    inputs: _ViewInputs
//  ) -> _ViewOutputs where SelectionValue: Hashable {
//    
//  }
//
//  public static func _makeViewList<SelectionValue>(
//    value: _GraphValue<_TabViewValue<WhiteboardTabViewStyle, SelectionValue>>,
//    inputs: _ViewListInputs
//  ) -> _ViewListOutputs where SelectionValue: Hashable {
//
//  }
//
//
//}

public struct TabView<Tab: Tabbable>: View {
  @Binding public var selection: Tab

  @ViewBuilder var views: some View {
    Text("")
      .tag(0)

    Text("")
      .tag(1)
  }

  public var body: some View {
    stack {
      GeometryReader { geo in
        ZStack {
          Text("")
          ForEach(allTabs, id: \.self) {
            $0.tab
              .offset(
                tabOffset(geoSize: geo.size, factor: allTabs.firstIndex(of: $0)! - allTabs.firstIndex(of: selection)!)
              )
          }
        }
      }

      TabBar(selection: $selection)
        .frame(maxWidth: displaySideTabbar ? 70 : nil, maxHeight: displaySideTabbar ? nil : 70)
        .padding(10)
    }
    .animation(.default, value: selection)
    .animation(.default, value: displaySideTabbar)
  }

  public init(selection: Binding<Tab>) { _selection = selection }

  private var displaySideTabbar: Bool { vSize == .compact }
  @Environment(\.verticalSizeClass) private var vSize

  private var currentIndex: Int { allTabs.firstIndex(of: selection)! }
  private var previous: Tab? { currentIndex > 0 ? allTabs[currentIndex - 1] : nil }
  private var next: Tab? { (currentIndex < allTabs.count - 1) ? allTabs[currentIndex + 1] : nil }
  private var allTabs: [Tab] { Array(Tab.allCases) }

  @ViewBuilder
  private func stack<Content: View>(@ViewBuilder content: () -> Content) -> some View {
    if displaySideTabbar {
      HStack(content: content)
    } else {
      VStack(content: content)
    }
  }

  private func tabOffset(geoSize: CGSize, factor: Int) -> CGSize {
    CGSize(
      width: displaySideTabbar ? 0 : geoSize.width * Double(factor),
      height: displaySideTabbar ? geoSize.height * Double(factor) : 0
    )
  }
}

#Preview {
    Binding.Preview(Example3Tab.dashboard) { binding in
      TabView<Example3Tab>(selection: binding)
    }
}

#Preview("Side Tabbar") {
  Binding.Preview(Example3Tab.dashboard) { binding in
    TabView<Example3Tab>(selection: binding)
      .environment(\.verticalSizeClass, .compact)
  }
}

#Preview("4 Tabs") {
    Binding.Preview(Example4Tab.dashboard) { binding in
      TabView<Example4Tab>(selection: binding)
    }
}

#endif
