//
//  CalendarDatePicker.swift
//  Vacas
//
//  Created by Igor Blinnikov on 28.12.2021.
//

import SwiftUI

struct CalendarDatePicker: View {
  @Binding var currentDate: Date
  var body: some View {
    VStack(spacing: 35) {
      HStack(spacing: 20) {
        VStack(alignment: .leading, spacing: 10) {
          Text("2021")
            .font(.caption)
            .fontWeight(.semibold)
          
          Text("December")
            .font(.title.bold())
        }
        
        Spacer(minLength: 0)
        
        Button {} label: {
          Image(systemName: "chevron.left")
        }
        Button {} label: {
          Image(systemName: "chevron.right")
        }
      }
      .padding(.horizontal)
    }
  }
}

struct CalendarDatePicker_Previews: PreviewProvider {
  static var previews: some View {
    CalendarDatePicker(currentDate: Binding.constant(Date()))
  }
}
