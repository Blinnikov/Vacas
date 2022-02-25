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
  
  var calendarServiceSection: some View {
    Text("Service to fetch holidays from") // CoppClark?
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
  }
}
