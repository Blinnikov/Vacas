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
    TabView {
      StatisticsView()
        .tabItem {
          VStack {
//            Image(systemName: "circle.hexagongrid.circle")
//            Image(systemName: "circle.hexagongrid.circle.fill")
//            Image(systemName: "circle.circle.fill")
//            Image(systemName: "lines.measurement.horizontal")
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
    let settingStore = SettingsStore(named: "Preview")
    let statistics = StatisticsViewModel(with: settingStore)
    let calendar = CalendarViewModel(with: settingStore)
    
    ContentView()
      .environmentObject(settingStore)
      .environmentObject(statistics)
      .environmentObject(calendar)
  }
}
