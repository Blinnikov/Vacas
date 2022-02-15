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
      CalendarView()
        .tabItem {
          VStack {
            Image(systemName: "calendar")
            Text("Calendar")
          }
        }
        .tag(0)
      
      SettingsView()
        .tabItem {
          VStack {
            Image(systemName: "gear")
            Text("Settings")
          }
        }
        .tag(1)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
