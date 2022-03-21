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
      
      HStack {
        Text("Working days this year:")
        Spacer()
        Text("\(statistics.workingDaysThisYear)")
      }
      .padding()
      
      HStack {
        Text("Vacation days gained:")
        Spacer()
        Text("\(statistics.vacationDaysGained)")
      }
      .padding()
      
      HStack {
        Text("Vacation days spent this year:")
        Spacer()
        Text("\(statistics.vacationDaysSpentThisYear)")
      }
      .padding()
      
      HStack {
        Text("Vacation days left this year:")
        Spacer()
        Text("\(statistics.vacationDaysLeftThisYear)")
      }
      .padding()
      
      Spacer()
    }
    
//      .frame(minWidth: 300, minHeight: 350)
  }
}

struct DeveloperInfoView_Previews: PreviewProvider {
  static var previews: some View {
    DeveloperInfoView()
  }
}
