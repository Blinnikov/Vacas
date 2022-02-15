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
          Image(systemName: "circle.fill").foregroundColor(settingsStore.settings.color)
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
    
    NavigationView {
      Form {
        appearanceSection
        dayAmountSection
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
