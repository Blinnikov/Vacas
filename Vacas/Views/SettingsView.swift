//
//  SettingsView.swift
//  Vacas
//
//  Created by Igor Blinnikov on 27.12.2021.
//

import SwiftUI

struct SettingsView: View {
  @EnvironmentObject var settingsStore: SettingsStore
  
  @State var appearance: Int = 2
  @State var hireDate: Date = Date(timeIntervalSince1970: 0)
  
  var body: some View {
//    List {
//      Section {
//        // TODO: I want two features from this picker:
//        // 1) ability to have the date unset
//        // 2) open calendar on current week - no one wants to go back into future from 1970 clicking through all the year along the way
//        // Probably we need to support shadow variable to suit these needs
//        DatePicker("Hire Date (\(hireDate.isUnset ? "unset" : "set"))", selection: $hireDate, displayedComponents: .date)
//
//        Text("Vacation days per year - 28") // Stepper
//
//        Text("Days that can be compensated - 3") // Stepper
//
//        Text("Service to fetch holidays from") // CoppClark?
//      }
//    }
    
    NavigationView {
      Form {
        appearanceSection
        dayAmountSection
        datesSection
      }
      .navigationTitle("Settings")
    }
  }
  
  var appearanceSection: some View {
    Section(header: Text("Appearance")) {
      Picker("Appearance", selection: $settingsStore.settings.appearance) {
        Text("Light").tag(Appearance.light)
        Text("Dark").tag(Appearance.dark)
        Text("System").tag(Appearance.system)
      }
      .pickerStyle(SegmentedPickerStyle())
      
      ColorPicker("Tint color", selection: $settingsStore.settings.color)
      
      HStack {
        Text("Default colors")
        Spacer()
        
        ForEach([Color.selection, Color.plum, Color.peach], id: \.self) { color in
          Image(systemName: "circle.fill").foregroundColor(color)
            .onTapGesture {
              settingsStore.setTintColor(color)
            }
        }
      }
    }
  }
  
  var datesSection: some View {
    Section(header: Text("Dates")) {
      DatePicker("Hire date", selection: $settingsStore.settings.hireDate, displayedComponents: .date)
    }
  }
  
  var dayAmountSection: some View {
    Section(header: Text("Vacation days per year")) {
      Stepper("Base days: \(settingsStore.settings.vacationDaysAmount)", value: $settingsStore.settings.vacationDaysAmount, in: 7...40)
      VStack {
        Stepper("Extra days: \(settingsStore.settings.extraVacationDaysAmount)", value: $settingsStore.settings.extraVacationDaysAmount, in: 0...7)
        HStack {
          Text("Extra days amount that can be compensated")
            .font(.caption2)
            .foregroundColor(.gray)
          Spacer()
        }
      }
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
  }
}
