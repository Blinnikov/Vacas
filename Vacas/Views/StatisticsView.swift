//
//  StatisticsView.swift
//  Vacas
//
//  Created by Igor Blinnikov on 14.03.2022.
//

import SwiftUI

struct StatisticsView: View {
  @EnvironmentObject var statistics: StatisticsViewModel
  
  var body: some View {
    GeometryReader { proxy in
      VStack {
        HStack {
          // TODO: Get rid of this title
          // Make some cool representative start screen
          Text("Statistics")
            .font(.title)
            .padding()
          
          Spacer()
        }
        
        listItem(title: "Working days this year", statistics.workingDaysThisYear)
        
        listItem(title: "Vacation days gained", statistics.vacationDaysGained)
        
        listItem(title: "Vacation days spent this year", statistics.vacationDaysSpentThisYear)
        
        listItem(title: "Vacation days left this year", statistics.vacationDaysLeftThisYear)
        
        Divider()
        
        circle(in: proxy.size)
        
        Divider()
        
        listItem(title: "Width", Int(proxy.size.width))
        
        listItem(title: "Height", Int(proxy.size.height))
        
//        Spacer()
      }
    }
    .border(Color.red, width: 2)
  }
  
  private func circle(in size: CGSize) -> some View {
    let CircleRatio = 0.5
    let CircleLineWidth: CGFloat = 15
    let CircleShadow: CGFloat = 10
    let CircleColor = Color.green
    let CircleFontSize: CGFloat = 60
    
    let circleWidth = CircleRatio * size.width
    
    let overlay = Circle().stroke(CircleColor, lineWidth: CircleLineWidth).shadow(radius: CircleShadow)
    return ZStack {
      Circle()
        .fill(.clear)
        .frame(width: circleWidth, height: circleWidth)
        .overlay(overlay)
      
      // FIX: Shows wrong count on Main tab
      Text("\(statistics.vacationDaysLeftThisYear)")
        .foregroundColor(CircleColor)
        .font(.system(size: CircleFontSize))
    }
  }
  
  func listItem(title: String, _ amount: Int) -> some View {
    HStack {
      Text("\(title)")
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
    StatisticsView()
      .environmentObject(statistics)
  }
}
