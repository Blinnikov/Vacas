//
//  SettingsView.swift
//  Vacas
//
//  Created by Igor Blinnikov on 27.12.2021.
//

import SwiftUI

struct SettingsView: View {
  @State var appearance: Int = 2
  @State var hireDate: Date = Date(timeIntervalSince1970: 0)
  
  var body: some View {
    List {
      // TODO: Add Navigation stack and use navigationTitle?
      // or something similar
      Text("Settings")
        .font(.largeTitle)
      
      Section("Appearance") {
        Picker("Appearance", selection: $appearance) {
          Text("Light").tag(0)
          Text("Dark").tag(1)
          Text("System").tag(2)
        }
        .pickerStyle(SegmentedPickerStyle())
        
        HStack {
          Text("Tint color")
          Spacer()
          Image(systemName: "circle.fill").foregroundColor(Color.selection)
          Image(systemName: "circle.fill").foregroundColor(Color.plum)
          Image(systemName: "circle.fill").foregroundColor(Color.peach)
        }
      }
      
      Section {
        DatePicker("Hire Date", selection: $hireDate, displayedComponents: .date)
        
        Text("Vacation days per year - 28") // Stepper
        
        Text("Days that can be compensated - 3") // Stepper
        
        Text("Service to fetch holidays from") // CoppClark?
      }
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
  }
}
