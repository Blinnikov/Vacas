//
//  CalendarDatePicker.swift
//  Vacas
//
//  Created by Igor Blinnikov on 28.12.2021.
//

import SwiftUI

struct CalendarDatePicker: View {
  // TODO: support internationalization - weeks that start from Monday
  // TODO: support localization - I do not only want these day names to be in English
  // TODO: date formatters - Mon vs Monday vs M ?
  let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
  let today = Date()
  
  @EnvironmentObject var viewModel: CalendarViewModel
  
  @Binding var selectedDate: Date
  @State private var currentDate = Date()
  @State private var selectedMonthOffset = 0
  private let scheduleChangeRecords = ScheduleRecord.testData
  
  var body: some View {
    VStack(spacing: 35) {
      // Month switcher
      // TODO: Extract as headline view?
      HStack(spacing: 20) {
        VStack(alignment: .leading, spacing: 10) {
          Text(self.currentDate.yearString)
            .font(.caption)
            .fontWeight(.semibold)
          
          Text(self.currentDate.monthString)
            .font(.title.bold())
        }
        
        Spacer(minLength: 0)
        
        Button {
          withAnimation {
            selectedMonthOffset -= 1
          }
        } label: {
          Image(systemName: "chevron.left")
        }
        Button {
          withAnimation {
            selectedMonthOffset += 1
          }
        } label: {
          Image(systemName: "chevron.right")
        }
      }
      .padding(.horizontal)
      
      // Day names
      HStack(spacing: 0) {
        ForEach(days, id: \.self) { day in
          Text(day)
            .font(.callout)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity) // Is it OK? Looks like it does the same as interweaving Texts with Spacers
        }
      }
      
      // Day numbers
      let columns = Array(repeating: GridItem(.flexible()), count: 7)
      LazyVGrid(columns: columns, spacing: 15) {
        ForEach(allDaysOfSelectedMonth()) { item in
          CardView(dayItem: item)
            .background(
              Capsule()
                .fill(viewModel.selectionColor)
                .padding(.horizontal, 8)
                .opacity(item.date != nil && item.date!.inSameDayAs(selectedDate) ? 1 : 0)
            )
            .overlay(selectionOverlay(for: item.date))
            .onTapGesture {
              guard let date = item.date else {
                return
              }
              selectedDate = date
            }
        }
      }
    }
    .onChange(of: selectedMonthOffset) { _ in
      currentDate = theSameDateAsNowInSelectedMonth()
    }
    
    // TODO: It's badly placed. `body` func returns 2 views.
    let records = scheduleRecords(for: selectedDate)
    DayDetailsView(records: records)
      .padding(.horizontal)
  }
  
  func selectionOverlay(for date: Date?) -> some View {
    VStack {
      HStack {
        Spacer(minLength: 0)
        Circle()
          .stroke(viewModel.selectionColor, lineWidth: 2)
          .frame(width: DrawingConstants.selectedDayFrameWidth)
          .offset(y: DrawingConstants.selectedDayFrameOffset)
          .opacity(opacity(for: date))
        Spacer(minLength: 0)
      }
      Spacer()
    }
  }
  
  func CardView(dayItem: DayItem) -> some View {
    VStack {
      if let date = dayItem.date, let day = dayItem.number {
        
        Text("\(day)")
          .font(.title3.bold())
          .foregroundColor(date.inSameDayAs(selectedDate) ? .white : .primary)
          .frame(maxWidth: .infinity)
        
        Spacer()
        
        if let records = scheduleRecords(for: date), !records.isEmpty {
          Markers(records: records)
        }
      }
    }
    .padding(.vertical, 8)
    .frame(height: 60, alignment: .top)
  }

  func opacity(for date: Date?) -> Double {
    guard let date = date else {
      return 0
    }
    return date.inSameDayAs(today) && !date.inSameDayAs(selectedDate) ? 1 : 0
  }
  
  func scheduleRecords(for day: Date) -> [ScheduleRecord] {
    return self.scheduleChangeRecords.filter{ record in
      record.date.inSameDayAs(day)
    }
  }
  
  func hasScheduleRecord(for day: Date?) -> Bool {
    guard let day = day else {
      return false
    }
    
    return !scheduleRecords(for: day).isEmpty
  }
  
  func theSameDateAsNowInSelectedMonth() -> Date {
    Date().theSameDay(in: self.selectedMonthOffset)
  }
  
  func allDaysOfSelectedMonth() -> [DayItem] {
    let calendar = Calendar.current
    let todayInSelectedMonth = theSameDateAsNowInSelectedMonth()
    
    var days = todayInSelectedMonth.allDaysOfMonth().compactMap { date -> DayItem in
      let day = calendar.component(.day, from: date)
      return DayItem(number: day, date: date)
    }
    
    let firstWeekDay = calendar.component(.weekday, from: days.first?.date ?? Date())
    
    for _ in 0..<firstWeekDay - 1 {
      days.insert(DayItem(number: -1, date: nil), at: 0)
    }
    
    return days
  }
}

struct DrawingConstants {
  static let selectedDayFrameWidth: CGFloat = 38
  static let selectedDayFrameOffset: CGFloat = -5
}

struct CalendarDatePicker_Previews: PreviewProvider {
  static var previews: some View {
    let viewModel = CalendarViewModel(with: SettingsStore(named: "Preview"))
    CalendarDatePicker(selectedDate: Binding.constant(Date()))
      .environmentObject(viewModel)
  }
}
