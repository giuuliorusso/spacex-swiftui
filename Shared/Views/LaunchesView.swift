//
//  LaunchesView.swift
//  SpaceX
//
//  Created by Giulio Russo on 22/09/20.
//

import SwiftUI

struct LaunchesView: View {
  @EnvironmentObject private var store: Store

  #if os(iOS)
  let listStyle = PlainListStyle()
  #else
  let listStyle = DefaultListStyle()
  #endif

  var body: some View {
    if store.upcomingLaunches.isEmpty || store.pastLaunches.isEmpty {
      ProgressView()
        .navigationTitle("Launches")
        .onAppear { store.fetchUpcomingLaunches() }
        .onAppear { store.fetchPastLaunches() }
    } else {
      list
        .navigationTitle("Launches")
    }
  }

  var list: some View {
    let n1 = store.upcomingLaunches.count
    let n2 = store.pastLaunches.count

    return List {
      Section(header: Header(text: "Upcoming", n: n1)) {
        ForEach(store.upcomingLaunches) { launch in
          LaunchRow(launch: launch)
        }
      }

      Section(header: Header(text: "Past", n: n2)) {
        ForEach(store.pastLaunches.reversed()) { launch in
          LaunchRow(launch: launch)
        }
      }
    }.listStyle(listStyle)
  }

  struct Header: View {
    let text: String
    let n: Int

    var body: some View {
      HStack {
        Text(text)
        Spacer()
        Text("\(n)")
      }
    }
  }
}

struct LaunchesView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      LaunchesView()
        .environmentObject(Store())
    }
  }
}
