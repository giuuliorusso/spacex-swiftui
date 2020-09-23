//
//  SpaceXApp.swift
//  Shared
//
//  Created by Giulio Russo on 22/09/20.
//

import SwiftUI

@main
struct SpaceXApp: App {
  @StateObject private var store = Store()

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(store)
    }
  }
}
