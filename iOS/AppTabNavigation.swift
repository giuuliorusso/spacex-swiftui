//
//  AppTabNavigation.swift
//  SpaceX (iOS)
//
//  Created by Giulio Russo on 23/09/20.
//

import SwiftUI

struct AppTabNavigation: View {
  var body: some View {
    TabView {
      NavigationView {
        LaunchesView()
      }.tabItem {
        Image(systemName: "paperplane")
        Text("Launches")
      }

      NavigationView {
        SearchView()
      }.tabItem {
        Image(systemName: "magnifyingglass")
        Text("Search")
      }
    }
  }
}

struct AppTabNavigation_Previews: PreviewProvider {
  static var previews: some View {
    AppTabNavigation()
      .environmentObject(Store())
  }
}
