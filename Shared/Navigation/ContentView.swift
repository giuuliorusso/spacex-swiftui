//
//  ContentView.swift
//  Shared
//
//  Created by Giulio Russo on 22/09/20.
//

import SwiftUI

struct ContentView: View {
  #if os(iOS)
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass
  #endif

  var body: some View {
    #if os(iOS)
    if horizontalSizeClass == .compact {
      AppTabNavigation()
    } else {
      AppSidebarNavigation()
    }
    #else
    AppSidebarNavigation()
    #endif
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(Store())
  }
}
