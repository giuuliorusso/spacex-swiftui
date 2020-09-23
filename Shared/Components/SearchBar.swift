//
//  SearchBar.swift
//  SpaceX
//
//  Created by Giulio Russo on 23/09/20.
//

import SwiftUI

// https://stackoverflow.com/questions/56490963

struct SearchBar: View {
  @Binding var text: String
  let placeholder: String

  @State private var showCancelButton = false

  var body: some View {
    HStack {
      HStack {
        Image(systemName: "magnifyingglass")

        TextField(placeholder, text: $text)
          .foregroundColor(.primary)
          .onTapGesture { showCancelButton = true }

        Button(action: { text = "" }) {
          Image(systemName: "xmark.circle.fill")
        }.opacity(text == "" ? 0 : 1)
      }
      .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
      .foregroundColor(.secondary)
      .background(Color(.secondarySystemBackground))
      .cornerRadius(10)

      if showCancelButton {
        Button("Cancel") {
          UIApplication.shared.endEditing(true)
          text = ""
          showCancelButton = false
        }
      }
    }
    .padding(.horizontal)
    .padding(.top, showCancelButton ? 16 : 0)
    .navigationBarHidden(showCancelButton)
    .animation(.default)
  }
}

// MARK: -

extension UIApplication {
  func endEditing(_ force: Bool) {
    windows
      .filter(\.isKeyWindow)
      .first?
      .endEditing(force)
  }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
  var gesture = DragGesture().onChanged { _ in
    UIApplication.shared.endEditing(true)
  }

  func body(content: Content) -> some View {
    content.gesture(gesture)
  }
}

extension View {
  func resignKeyboardOnDragGesture() -> some View {
    modifier(ResignKeyboardOnDragGesture())
  }
}

// MARK: -

struct SearchBar_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      SearchBar(text: .constant(""), placeholder: "Search")
        .preferredColorScheme(.light)
      SearchBar(text: .constant("CRS"), placeholder: "Search")
        .preferredColorScheme(.light)
      SearchBar(text: .constant(""), placeholder: "Search")
        .preferredColorScheme(.dark)
    }.previewLayout(.sizeThatFits)
  }
}
