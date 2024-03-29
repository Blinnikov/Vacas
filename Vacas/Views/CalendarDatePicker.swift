//
//  CalendarDatePicker.swift
//  Vacas
//
//  Created by Igor Blinnikov on 28.12.2021.
//

import SwiftUI

fileprivate let StubDayNumber = -1

struct CalendarDatePicker<DayItemRenderer: View>: View {
  // TODO: support internationalization - weeks that start from Monday
  // TODO: support localization - I do not only want these day names to be in English
  // TODO: date formatters - Mon vs Monday vs M ?
  let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
  
  @Binding var selectedDate: Date
  @Binding var visibleDate: Date
  @State private var visibleMonthOffset: Int
  // TODO: Provide default implementation
  // If I want to distribute this as a opensource component,
  // I don't to have to require users to do some basic things like create selection UI.
  // This component should work out of the box.
  private let dayRenderer: (DayItem) -> DayItemRenderer
  
  init(selection: Binding<Date>, visibleDate: Binding<Date>, @ViewBuilder dayRenderer: @escaping (DayItem) -> DayItemRenderer) {
    self._selectedDate = selection
    self._visibleDate = visibleDate
    let offset = visibleDate.wrappedValue.monthsOffset(from: selection.wrappedValue)
    self._visibleMonthOffset = State(initialValue: offset)
    self.dayRenderer = dayRenderer
  }
  
  var body: some View {
    VStack(spacing: 35) {
      // Month switcher
      // TODO: Extract as headline view?
      HStack(spacing: 20) {
        VStack(alignment: .leading, spacing: 10) {
          Text(self.visibleDate.yearString)
            .font(.caption)
            .fontWeight(.semibold)
          
          Text(self.visibleDate.monthString)
            .font(.title.bold())
        }
        
        Spacer(minLength: 0)
        
        // TODO: Add swipe gestures to shitch months
        Button {
          withAnimation {
            changeSelectedMonth(offset: -1)
          }
        } label: {
          Image(systemName: "chevron.left")
        }
        Button {
          withAnimation {
            changeSelectedMonth(offset: 1)
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
          dayRenderer(item)
            .onTapGesture {
              guard let date = item.date else {
                return
              }
              selectedDate = date
              visibleMonthOffset = 0
            }
        }
      }
    }
  }
  
  func changeSelectedMonth(offset: Int) {
    visibleMonthOffset += offset
    visibleDate = theSameDateAsNowInSelectedMonth()
  }
  
  func theSameDateAsNowInSelectedMonth() -> Date {
    selectedDate.theSameDay(in: self.visibleMonthOffset)
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
      days.insert(DayItem(number: StubDayNumber, date: nil), at: 0)
    }
    
    return days
  }
}

struct CalendarDatePicker_Previews: PreviewProvider {
  static var previews: some View {
    let selection = Binding.constant(Date())
    let visibleDate = Binding.constant(selection.wrappedValue.theSameDay(in: -1))
    
    CalendarDatePicker(
      selection: selection,
      visibleDate: visibleDate
    ) { dayItem in
      if dayItem.number != StubDayNumber {
        Text("\(dayItem.number)")
      } else {
        Text("")
      }
    }
  }
}
