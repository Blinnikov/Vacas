//
//  CalendarView.swift
//  Vacas
//
//  Created by Igor Blinnikov on 27.12.2021.
//

import SwiftUI

struct CalendarView: View {
  var body: some View {
    VStack {
      Text("Calendar View will be there")
        .font(.headline)
      Text("You just need to wait a little bit")
        .font(.subheadline)
        .foregroundColor(.secondary)
    }
  }
}

struct CalendarView_Previews: PreviewProvider {
  static var previews: some View {
    CalendarView()
  }
}
