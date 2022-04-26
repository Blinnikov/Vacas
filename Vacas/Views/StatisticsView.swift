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
    let CircleFontSize: CGFloat = CircleRatio * 100 + 10
    let frameWidth = CircleRatio * size.width
    
    // MARK: - Outer circle vars
    let VacationsColor = Color.green
    let vacationsProgress = CGFloat(statistics.vacationDaysLeftThisYear) / CGFloat(statistics.totalVacationDaysPerYear)
    
    // MARK: - Inner circle vars
    let DaysOffCircleColor = Color.pink
    let daysOffCircleShown = statistics.daysOffTaken > 0
    let daysOffProgress = CGFloat (statistics.daysOffTaken) / CGFloat(statistics.MaximumDaysOffAllowed)
    
    return ZStack {
      // TODO: Extract as a separate view?
      // TODO: Add animation for circle rotation onAppear
      TimeOffProgressCircle(color: VacationsColor, progress: vacationsProgress)
      
      TimeOffProgressCircle(color: DaysOffCircleColor, progress: daysOffProgress)
        .opacity(daysOffCircleShown ? 1 : 0)
        .padding(32)
      
      HStack(alignment: .firstTextBaseline) {
        Text("\(statistics.vacationDaysLeftThisYear)")
          .foregroundColor(VacationsColor)
          .font(.system(size: CircleFontSize))
        Text(" / \(statistics.totalVacationDaysPerYear)")
          .foregroundColor(VacationsColor)
      }
    }
    .frame(width: frameWidth, height: frameWidth)
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

struct TimeOffProgressCircle: View {
  let color: Color
  let progress: CGFloat
  let CircleLineWidth: CGFloat = 20
  let CircleBackgroundOpacity = 0.23
  let CircleShadow: CGFloat = 10
  
  var body: some View {
    Group {
      Circle()
        .stroke(color.opacity(CircleBackgroundOpacity), lineWidth: CircleLineWidth)
      
      Circle()
        .trim(from: 0, to: progress)
        .stroke(color, style: StrokeStyle(lineWidth: CircleLineWidth, lineCap: .round))
        .shadow(radius: CircleShadow)
        .rotationEffect(.degrees(-90))
    }
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
