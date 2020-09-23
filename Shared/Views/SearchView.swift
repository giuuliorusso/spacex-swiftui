//
//  SearchView.swift
//  SpaceX
//
//  Created by Giulio Russo on 23/09/20.
//

import SwiftUI

struct SearchView: View {
  @EnvironmentObject private var store: Store
  @State private var query = ""

  var body: some View {
    VStack {
      SearchBar(text: $query, placeholder: "Search")

      if query.isEmpty {
        Spacer()
      } else {
        list
      }
    }
    .navigationTitle("Search")
    .onAppear { store.fetchUpcomingLaunches() }
    .onAppear { store.fetchPastLaunches() }
  }

  var list: some View {
    let (upcoming, past) = store.searchAll(query: query)

    return List {
      Section(header: Text("Upcoming launches")) {
        ForEach(upcoming) { launch in
          LaunchRow(launch: launch)
        }
      }

      Section(header: Text("Past launches")) {
        ForEach(past.reversed()) { launch in
          LaunchRow(launch: launch)
        }
      }
    }
    .listStyle(GroupedListStyle())
    .resignKeyboardOnDragGesture()
  }
}

struct SearchView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      SearchView()
        .environmentObject(Store())
    }
  }
}
