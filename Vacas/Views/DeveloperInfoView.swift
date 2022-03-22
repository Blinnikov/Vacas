//
//  DeveloperInfoView.swift
//  Vacas
//
//  Created by Igor Blinnikov on 14.03.2022.
//

import SwiftUI

struct DeveloperInfoView: View {
  @EnvironmentObject var statistics: StatisticsViewModel
  
  var body: some View {
    VStack {
      HStack {
        Text("Developer Info")
          .font(.title)
          .padding()
        
        Spacer()
      }
      
      listItem(title: "Working days this year", statistics.workingDaysThisYear)
      
      listItem(title: "Vacation days gained", statistics.vacationDaysGained)
      
      listItem(title: "Vacation days spent this year", statistics.vacationDaysSpentThisYear)
      
      listItem(title: "Vacation days left this year", statistics.vacationDaysLeftThisYear)
      
      Spacer()
    }
    
//      .frame(minWidth: 300, minHeight: 350)
  }
  
  func listItem(title: String, _ amount: Int) -> some View {
    HStack {
      Text("\(title):")
      Spacer()
      Text("\(amount)")
    }
    .padding()
  }
}

struct DeveloperInfoView_Previews: PreviewProvider {
  static var previews: some View {
    let settingStore = SettingsStore(named: "Preview")
    let statistics = StatisticsViewModel(with: settingStore)
    DeveloperInfoView()
      .environmentObject(statistics)
  }
}
