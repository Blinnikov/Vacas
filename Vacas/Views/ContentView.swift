//
//  ContentView.swift
//  Vacas
//
//  Created by Igor Blinnikov on 23.12.2021.
//

import SwiftUI

struct ContentView: View {
  @State var selectedTab = 0
  
  var body: some View {
    TabView(selection: $selectedTab) {
      StatisticsView()
        .tabItem {
          VStack {
            Image(systemName: "circle.hexagongrid")
            Text("Statistics")
          }
        }
        .tag(0)
      
      CalendarView()
        .tabItem {
          VStack {
            Image(systemName: "calendar")
            Text("Calendar")
          }
        }
        .tag(1)
      
      SettingsView()
        .tabItem {
          VStack {
            Image(systemName: "gear")
            Text("Settings")
          }
        }
        .tag(2)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let settingsStore = SettingsStore(named: "Preview")
    let recordsStore = ScheduleRecordsStore(named: "Preview")
    let statistics = StatisticsViewModel(with: settingsStore, and: recordsStore)
    let calendar = CalendarViewModel(with: settingsStore)
    
    ContentView()
      .environmentObject(settingsStore)
      .environmentObject(statistics)
      .environmentObject(calendar)
  }
}
