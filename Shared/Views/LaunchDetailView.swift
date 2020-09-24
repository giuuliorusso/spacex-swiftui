//
//  LaunchDetailView.swift
//  SpaceX
//
//  Created by Giulio Russo on 24/09/20.
//

import KingfisherSwiftUI
import SwiftUI

struct LaunchDetailView: View {
  let launch: Launch

  var body: some View {
    List {
      // Patch
      if let patch = launch.links.patch.large {
        Section(header: HStack {
          Spacer()
          KFImage(patch)
            .placeholder { ProgressView() }
            .resizable()
            .frame(width: 270, height: 270)
            .shadow(color: .secondary, radius: 5)
            .padding()
            .padding(.top)
          Spacer()
        }) {}
      }

      // Date
      Section(header: Text("Date")) {
        if launch.date > Date() {
          ClickableDate(date: launch.date, leading: "In ")
        } else {
          ClickableDate(date: launch.date, trailing: " ago")
        }
      }

      // Details
      Section(header: Text("Details")) {
        Text(launch.details ?? "None")
      }

      // Links
      Section(header: Text("Links")) {
        if let wikipedia = launch.links.wikipedia {
          Link("Wikipedia", destination: wikipedia)
            .foregroundColor(.accentColor)
        }

        if let youtube = launch.links.youtube {
          Link("YouTube", destination: youtube)
            .foregroundColor(.accentColor)
        }

        if launch.links.wikipedia == nil && launch.links.youtube == nil {
          Text("None")
        }
      }
    }
    .listStyle(GroupedListStyle())
    .navigationTitle(launch.name)
  }
}

struct LaunchDetailView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      LaunchDetailView(launch: testLaunches[0])
    }
  }
}
