//
//  Utils.swift
//  SpaceX
//
//  Created by Giulio Russo on 22/09/20.
//

import Foundation

var dateFormatter: DateFormatter {
  let df = DateFormatter()
  df.dateStyle = .medium
  df.timeStyle = .short
  df.locale = Locale.current

  return df
}
