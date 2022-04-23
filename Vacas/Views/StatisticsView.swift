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
            
            listItem(title: "Days off taken", statistics.daysOffTaken)
          }
          
          Divider()
        }
        
        circle(in: proxy.size)
      }
    }
  }
  
  private func circle(in size: CGSize) -> some View {
    let CircleRatio = 0.8
    let CircleLineWidth: CGFloat = 20
    let CircleShadow: CGFloat = 10
    let OuterCircleColor = Color.green
    let InnerCircleColor = Color.pink
    let TextColor = Color.green
    let CircleBackgroundOpacity = 0.23
    let CircleFontSize: CGFloat = CircleRatio * 100 + 10
    
    let circleWidth = CircleRatio * size.width
    let progress: CGFloat = CGFloat(statistics.vacationDaysLeftThisYear) / CGFloat(statistics.totalVacationDaysPerYear)
    
    return ZStack {
      // TODO: Extract as a separate view?
      // TODO: Add animation for circle rotation onAppear
      // MARK: - Circle start
      Circle()
        .stroke(OuterCircleColor.opacity(CircleBackgroundOpacity), lineWidth: CircleLineWidth)
      
      Circle()
        .trim(from: 0, to: progress)
        .stroke(OuterCircleColor, style: StrokeStyle(lineWidth: CircleLineWidth, lineCap: .round))
        .shadow(radius: CircleShadow)
        .rotationEffect(.degrees(-90))
      // MARK: Circle end -
      
      // TODO: Show only if there're days off taken
      Group {
        Circle()
          .stroke(InnerCircleColor.opacity(CircleBackgroundOpacity), lineWidth: CircleLineWidth)
        
        Circle()
          .trim(from: 0, to: 0.2)
          .stroke(InnerCircleColor, style: StrokeStyle(lineWidth: CircleLineWidth, lineCap: .round))
          .shadow(radius: CircleShadow)
          .rotationEffect(.degrees(-90))
      }
      .padding(32)
      
      HStack(alignment: .firstTextBaseline) {
        Text("\(statistics.vacationDaysLeftThisYear)")
          .foregroundColor(TextColor)
          .font(.system(size: CircleFontSize))
        Text(" / \(statistics.totalVacationDaysPerYear)")
          .foregroundColor(TextColor)
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
