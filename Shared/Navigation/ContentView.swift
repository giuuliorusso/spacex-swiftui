//
//  ContentView.swift
//  Shared
//
//  Created by Giulio Russo on 22/09/20.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationView {
      LaunchesView()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(Store())
  }
}
