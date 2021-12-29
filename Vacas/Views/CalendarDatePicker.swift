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
  
  @Binding var selectedDate: Date
  @State private var currentDate = Date()
  @State private var selectedMonthOffset = 0
  
  var body: some View {
    VStack(spacing: 35) {
      // Month switcher
      // TODO: Extract as headline view?
      HStack(spacing: 20) {
        VStack(alignment: .leading, spacing: 10) {
          Text(currentYearString)
            .font(.caption)
            .fontWeight(.semibold)
          
          Text(currentMonthName)
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
        ForEach(extractDate()) { value in
          CardView(value: value)
            .background(
              Capsule()
                .fill(Color("Pink"))
                .padding(.horizontal, 8)
                .opacity(isSameDay(date1: value.date, date2: selectedDate) ? 1 : 0)
            )
            .overlay(
              Circle()
                .stroke(.red, lineWidth: 2)
                .padding(.horizontal, 8)
                .padding(.bottom, 16)
                .opacity(opacity(for: value.date))
            )
            .onTapGesture {
              selectedDate = value.date
            }
        }
      }
    }
    .onChange(of: selectedMonthOffset) { newValue in
      currentDate = theSameDateAsNowForCurrentlySelectedMonthOffset()
    }
  }
  
  func CardView(value: DateValue) -> some View {
    VStack {
      if value.day != -1 {
        Text("\(value.day)")
          .font(.title3.bold())
          .foregroundColor(isSameDay(date1: value.date, date2: selectedDate) ? .white : .primary)
          .frame(maxWidth: .infinity)
        
        Spacer()
      }
    }
    .padding(.vertical, 8)
    .frame(height: 60, alignment: .top)
  }
  
  func opacity(for date: Date) -> Double {
    isSameDay(date1: date, date2: currentDate) &&
    !isSameDay(date1: date, date2: selectedDate)
      ? 1
      : 0
  }
  
  func isSameDay(date1: Date, date2: Date) -> Bool {
    let calendar = Calendar.current
    return calendar.isDate(date1, inSameDayAs: date2)
  }
  
  var currentYearString: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY"
    return formatter.string(from: currentDate)
  }
  
  var currentMonthName: String {
    let formatter = DateFormatter()
    // MMMM - декабря
    // LLLL - декабрь
    formatter.dateFormat = "LLLL"
//    formatter.locale = Locale(identifier: "en-US")
    
    return formatter.string(from: currentDate)
  }
  
  func theSameDay(as date: Date, for monthOffset: Int) -> Date {
    print("Date() - \(Date())")
    print("Date().localDate() \(Date().localDate())")
    let calendar = Calendar.current
    guard let currentMonth = calendar.date(byAdding: .month, value: monthOffset, to: date) else {
      return Date()
    }
    
    return currentMonth
  }
  
  func theSameDateAsNowForCurrentlySelectedMonthOffset() -> Date {
    let now = Date() // TODO: use .localDate()
    return theSameDay(as: now, for: self.selectedMonthOffset)
  }
  
  func extractDate() -> [DateValue] {
    let calendar = Calendar.current
    let todayInSelectedMonth = theSameDateAsNowForCurrentlySelectedMonthOffset()
    
    print("Current month: \(todayInSelectedMonth)")
    
    var days = todayInSelectedMonth.allDaysOfMonth().compactMap { date -> DateValue in
      let day = calendar.component(.day, from: date)
      return DateValue(day: day, date: date)
    }
    
    print(days)
    
    let firstWeekDay = calendar.component(.weekday, from: days.first?.date ?? Date())
    
    for _ in 0..<firstWeekDay - 1 {
      days.insert(DateValue(day: -1, date: Date()), at: 0)
    }
    
    return days
  }
}

struct CalendarDatePicker_Previews: PreviewProvider {
  static var previews: some View {
    CalendarDatePicker(selectedDate: Binding.constant(Date()))
  }
}
