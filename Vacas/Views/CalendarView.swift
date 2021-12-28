//
//  CalendarView.swift
//  Vacas
//
//  Created by Igor Blinnikov on 27.12.2021.
//

import SwiftUI

struct CalendarView: View {
  @State var currentDate = Date()
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack(spacing: 20) {
        CalendarDatePicker(currentDate: $currentDate)
      }
    }
  }
}

struct CalendarView_Previews: PreviewProvider {
  static var previews: some View {
    CalendarView()
  }
}
