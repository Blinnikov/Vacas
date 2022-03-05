//
//  CalendarView.swift
//  Vacas
//
//  Created by Igor Blinnikov on 27.12.2021.
//

import SwiftUI

struct CalendarView: View {
  @State var selection = Date()
  
  var body: some View {
    VStack {
      HStack {
        Spacer()
        Button {
          
        } label: {
          Image(systemName: "ant.circle")
        }
        .padding(.horizontal)
      }
      ScrollView(.vertical, showsIndicators: false) {
        VStack(spacing: 20) {
          CalendarDatePicker(selectedDate: $selection)
        }
        .padding(.vertical)
      }
    }
//    .safeAreaInset(edge: .bottom) {
//      buttons
//    }
  }
  
  var buttons: some View {
    HStack {
      Button {
        
      } label: {
        Text("Add record")
          .fontWeight(.bold)
          .padding(.vertical)
          .frame(maxWidth: .infinity)
          .background(
            Color.peach, in: Capsule()
          )
      }
      
      Button {
        
      } label: {
        Text("Compensate")
          .fontWeight(.bold)
          .padding(.vertical)
          .frame(maxWidth: .infinity)
          .background(
            Color.plum, in: Capsule()
          )
      }
    }
    .padding(.horizontal)
    .padding(.top, 10)
    .foregroundColor(.white)
    .background(.ultraThinMaterial)
  }
}

struct CalendarView_Previews: PreviewProvider {
  static var previews: some View {
    CalendarView()
      .environmentObject(SettingsStore(named: "Preview"))
  }
}
