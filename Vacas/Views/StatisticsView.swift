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
      ZStack {
        VStack {
          Spacer()
          HStack {
            Spacer()
            // TODO: Get rid of this title
            // Make some cool representative start screen
            Text("Statistics")
              .font(.title)
              .padding(.horizontal)
              .padding(.bottom, 2)
          }
          
          Group {
            listItem(title: "Working days this year", statistics.workingDaysThisYear)
            
            listItem(title: "Vacation days gained", statistics.vacationDaysGained)
            
            listItem(title: "Vacation days spent this year", statistics.vacationDaysSpentThisYear)
            
            listItem(title: "Vacation days left this year", statistics.vacationDaysLeftThisYear)
          }
          
          Divider()
          
          VStack {
            listItem(title: "Width", Int(proxy.size.width))
            
            listItem(title: "Height", Int(proxy.size.height))
            Divider()
          }
          .padding(.bottom)
        }
        
        circle(in: proxy.size)
      }
    }
  }
  
  private func circle(in size: CGSize) -> some View {
    let CircleRatio = 0.7
    let CircleLineWidth: CGFloat = 20
    let CircleShadow: CGFloat = 10
    let CircleBackgroundColor = Color(red: 213, green: 241, blue: 221)
    let CircleColor = Color.green
    let CircleFontSize: CGFloat = CircleRatio * 100 + 10
    
    let circleWidth = CircleRatio * size.width
    let progress: CGFloat = CGFloat(statistics.vacationDaysLeftThisYear) / CGFloat(statistics.totalVacationDaysPerYear)
    
    return ZStack {
      Circle()
        .stroke(CircleBackgroundColor, lineWidth: CircleLineWidth)
      
      Circle()
        .trim(from: 0, to: progress)
        .stroke(CircleColor, style: StrokeStyle(lineWidth: CircleLineWidth, lineCap: .round))
        .shadow(radius: CircleShadow)
        .rotationEffect(.degrees(-90))
      
      HStack(alignment: .firstTextBaseline) {
        Text("\(statistics.vacationDaysLeftThisYear)")
          .foregroundColor(CircleColor)
          .font(.system(size: CircleFontSize))
        Text(" / \(statistics.totalVacationDaysPerYear)")
          .foregroundColor(CircleColor)
      }
    }
    .frame(width: circleWidth, height: circleWidth)
  }
  
  func listItem(title: String, _ amount: Int) -> some View {
    HStack {
      Spacer()
      Text("\(title)").font(.footnote)
      Text("\(amount)").font(.footnote).foregroundColor(.gray)
    }
    .padding(.horizontal)
  }
  }

struct DeveloperInfoView_Previews: PreviewProvider {
  static var previews: some View {
    let settingsStore = SettingsStore(named: "Preview")
    let recordsStore = ScheduleRecordsStore()
    let statistics = StatisticsViewModel(with: settingsStore, and: recordsStore)
    StatisticsView()
      .environmentObject(statistics)
  }
}
