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
  
  @Binding var currentDate: Date
  @State var currentMonth = 0
  
  var body: some View {
    let dates = Date().getAllDates()
    let extracted = extractDate()
    VStack(spacing: 35) {
      // Month switcher
      // TODO: Extract as headline view?
      HStack(spacing: 20) {
        VStack(alignment: .leading, spacing: 10) {
          Text(extractYearAndMonth()[0])
            .font(.caption)
            .fontWeight(.semibold)
          
          Text(extractYearAndMonth()[1])
            .font(.title.bold())
        }
        
        Spacer(minLength: 0)
        
        Button {
          withAnimation {
            currentMonth -= 1
          }
        } label: {
          Image(systemName: "chevron.left")
        }
        Button {
          withAnimation {
            currentMonth += 1
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
                .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
            )
            .onTapGesture {
              currentDate = value.date
            }
        }
      }
    }
    .onChange(of: currentMonth) { newValue in
      currentDate = getCurrentMont()
    }
  }
  
  func CardView(value: DateValue) -> some View {
    VStack {
      if value.day != -1 {
        Text("\(value.day)")
          .font(.title3.bold())
          .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? .white : .primary)
          .frame(maxWidth: .infinity)
        
        Spacer()
      }
    }
    .padding(.vertical, 8)
    .frame(height: 60, alignment: .top)
  }
  
  func isSameDay(date1: Date, date2: Date) -> Bool {
    let calendar = Calendar.current
    return calendar.isDate(date1, inSameDayAs: date2)
  }
  
  func extractYearAndMonth() -> [String] {
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY MMMM"
    
    let date = formatter.string(from: currentDate)
    return date.components(separatedBy: " ")
  }
  
  func getCurrentMont() -> Date {
    let calendar = Calendar.current
    guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
      return Date()
    }
    
    return currentMonth
  }
  
  func extractDate() -> [DateValue] {
    let calendar = Calendar.current
    let currentMonth = getCurrentMont()
    
    print("Current month: \(currentMonth)")
    
    var days = currentMonth.getAllDates().compactMap { date -> DateValue in
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
    CalendarDatePicker(currentDate: Binding.constant(Date()))
  }
}
