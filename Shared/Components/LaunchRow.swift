//
//  LaunchRow.swift
//  SpaceX
//
//  Created by Giulio Russo on 22/09/20.
//

import KingfisherSwiftUI
import SwiftUI

struct LaunchRow: View {
  let launch: Launch

  #if os(iOS)
  let padding: CGFloat = 0
  #else
  let padding: CGFloat = 8
  #endif

  var body: some View {
    NavigationLink(destination: LaunchDetailView(launch: launch)) {
      HStack {
        // Patch
        if let patch = launch.links.patch.small {
          KFImage(patch)
            .resizable()
            .frame(width: 50, height: 50)
        } else {
          Image(systemName: "paperplane")
            .frame(width: 50, height: 50)
        }

        // Text
        VStack(alignment: .leading) {
          Text(launch.name)
          Text(launch.date, formatter: dateFormatter)
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
      }.padding(.vertical, padding)
    }
  }
}

struct LaunchRow_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      LaunchRow(launch: testLaunches[0])
        .preferredColorScheme(.light)
      LaunchRow(launch: testLaunches[1])
        .preferredColorScheme(.light)
      LaunchRow(launch: testLaunches[0])
        .preferredColorScheme(.dark)
    }.previewLayout(.sizeThatFits)
  }
}
