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
  
  @Binding var selectedDate: Date
  @State private var currentDate = Date()
  @State private var selectedMonthOffset = 0
  
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
        ForEach(allDaysOfSelectedMonth()) { pair in
          CardView(day: pair.day, date: pair.date)
            .background(
              Capsule()
                .fill(Color.selection)
                .padding(.horizontal, 8)
                .opacity(pair.date != nil && pair.date!.inSameDayAs(selectedDate) ? 1 : 0)
            )
            .overlay(selectionOverlay(for: pair.date))
            .onTapGesture {
              if pair.date == nil {
                return
              }
              selectedDate = pair.date!
            }
        }
      }
    }
    .onChange(of: selectedMonthOffset) { _ in
      currentDate = theSameDateAsNowInSelectedMonth()
    }
  }
  
  func selectionOverlay(for date: Date?) -> some View {
    VStack {
      HStack {
        Spacer(minLength: 0)
        Circle()
          .stroke(Color.selection, lineWidth: 2)
          .frame(width: DrawingConstants.selectedDayFrameWidth)
          .offset(y: DrawingConstants.selectedDayFrameOffset)
          .opacity(opacity(for: date))
        Spacer(minLength: 0)
      }
      Spacer()
    }
  }
  
  func CardView(day: Int, date: Date?) -> some View {
    VStack {
      if let date = date {
        Text("\(day)")
          .font(.title3.bold())
          .foregroundColor(date.inSameDayAs(selectedDate) ? .white : .primary)
          .frame(maxWidth: .infinity)
        
        Spacer()
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
  
  func theSameDateAsNowInSelectedMonth() -> Date {
    Date().theSameDay(in: self.selectedMonthOffset)
  }
  
  func allDaysOfSelectedMonth() -> [DayDatePair] {
    let calendar = Calendar.current
    let todayInSelectedMonth = theSameDateAsNowInSelectedMonth()
    
    var days = todayInSelectedMonth.allDaysOfMonth().compactMap { date -> DayDatePair in
      let day = calendar.component(.day, from: date)
      return DayDatePair(day: day, date: date)
    }
    
    let firstWeekDay = calendar.component(.weekday, from: days.first?.date ?? Date())
    
    for _ in 0..<firstWeekDay - 1 {
      days.insert(DayDatePair(day: -1, date: nil), at: 0)
    }
    
    return days
  }
  
  struct DrawingConstants {
    static let selectedDayFrameWidth: CGFloat = 38
    static let selectedDayFrameOffset: CGFloat = -5
  }
}

struct CalendarDatePicker_Previews: PreviewProvider {
  static var previews: some View {
    CalendarDatePicker(selectedDate: Binding.constant(Date()))
  }
}
