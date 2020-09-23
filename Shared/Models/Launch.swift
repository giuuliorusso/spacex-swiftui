//
//  Launch.swift
//  SpaceX
//
//  Created by Giulio Russo on 22/09/20.
//

import Foundation

struct Launch: Decodable, Identifiable {
  var id: String
  var name: String
  var date_unix: TimeInterval

  var details: String?
  var links: Links

  var date: Date {
    Date(timeIntervalSince1970: date_unix)
  }
}

struct Links: Decodable {
  var patch: Patch
  var youtube_id: String?
  var wikipedia: URL?

  var youtube: URL? {
    if let id = youtube_id {
      return URL(string: "https://youtu.be/\(id)")!
    }
    return nil
  }
}

struct Patch: Decodable {
  var small: URL?
  var large: URL?
}

// MARK: -

let testLaunches = [
  Launch(
    id: "0",
    name: "CRS-20",
    date_unix: 1_583_556_631,
    details: "SpaceX's 20th and final Crew Resupply Mission under the original NASA CRS contract, this mission brings essential supplies to the International Space Station using SpaceX's reusable Dragon spacecraft. It is the last scheduled flight of a Dragon 1 capsule. (CRS-21 and up under the new Commercial Resupply Services 2 contract will use Dragon 2.) The external payload for this mission is the Bartolomeo ISS external payload hosting platform. Falcon 9 and Dragon will launch from SLC-40, Cape Canaveral Air Force Station and the booster will land at LZ-1. The mission will be complete with return and recovery of the Dragon capsule and down cargo.",
    links: Links(
      patch: Patch(
        small: URL(string: "https://images2.imgbox.com/53/22/dh0XSLXO_o.png")!,
        large: URL(string: "https://images2.imgbox.com/15/2b/NAcsTEB6_o.png")!
      ),
      youtube_id: "1MkcWK2PnsU",
      wikipedia: nil
    )
  ),
  Launch(
    id: "1",
    name: "CRS-20",
    date_unix: 1_583_556_631,
    details: nil,
    links: Links(patch: Patch(small: nil, large: nil), youtube_id: nil, wikipedia: nil)
  ),
]
