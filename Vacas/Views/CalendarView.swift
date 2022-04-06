//
//  CalendarView.swift
//  Vacas
//
//  Created by Igor Blinnikov on 27.12.2021.
//

import SwiftUI

struct CalendarView: View {
  @State private var selection = Date()
  @State private var visibleDate = Date().theSameDay(in: -1)
  @State private var developerInfoShown = false
  
  @EnvironmentObject var viewModel: CalendarViewModel
  
  // TODO: Read it from some ViewModel-like store or CoreData
  private let scheduleChangeRecords = ScheduleRecord.testData
  private let today = Date()
  
  var body: some View {
    VStack {
      HStack {
        Spacer()
        Button {
          developerInfoShown.toggle()
        } label: {
          Image(systemName: "ant.circle")
        }
        .padding(.horizontal)
        .popover(isPresented: $developerInfoShown) {
          DeveloperInfoView()
        }
      }
      ScrollView(.vertical, showsIndicators: false) {
        VStack(spacing: 20) {
          CalendarDatePicker(selection: $selection, visibleDate: $visibleDate) { dayItem in
            CardView(dayItem: dayItem)
              .background(
                Capsule()
                  .fill(viewModel.selectionColor)
                  .padding(.horizontal, 8)
                  .opacity(dayItem.date != nil && dayItem.date!.inSameDayAs(selection) ? 1 : 0)
              )
              .overlay(selectionOverlay(for: dayItem.date))
          }
          
          if visibleDate.monthsOffset(from: selection) == 0 {
            let records = scheduleRecords(for: selection)
            DayDetailsView(records: records)
              .padding(.horizontal)
          }
        }
        .padding(.vertical)
      }
    }
//    .safeAreaInset(edge: .bottom) {
//      buttons
//    }
  }
  
  func CardView(dayItem: DayItem) -> some View {
    VStack {
      if let date = dayItem.date, let day = dayItem.number {
        
        Text("\(day)")
          .font(.title3.bold())
          .foregroundColor(date.inSameDayAs(selection) ? .white : .primary)
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
  
  private func selectionOverlay(for date: Date?) -> some View {
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
  
  private func opacity(for date: Date?) -> Double {
    guard let date = date else {
      return 0
    }
    return date.inSameDayAs(today) && !date.inSameDayAs(selection) ? 1 : 0
  }
  
  private func scheduleRecords(for day: Date) -> [ScheduleRecord] {
    return self.scheduleChangeRecords.filter{ record in
      record.date.inSameDayAs(day)
    }
  }
  
  var buttons: some View {
    HStack {
      Button {
        
      } label: {
        Text("Add record")
          .fontWeight(.bold)
          .padding(.vertical)
          .frame(maxWidth: .infinity)
          .background(
            Color.peach, in: Capsule()
          )
      }
      
      Button {
        
      } label: {
        Text("Compensate")
          .fontWeight(.bold)
          .padding(.vertical)
          .frame(maxWidth: .infinity)
          .background(
            Color.plum, in: Capsule()
          )
      }
    }
    .padding(.horizontal)
    .padding(.top, 10)
    .foregroundColor(.white)
    .background(.ultraThinMaterial)
  }
  
  struct DrawingConstants {
    static let selectedDayFrameWidth: CGFloat = 38
    static let selectedDayFrameOffset: CGFloat = -5
  }
}

struct CalendarView_Previews: PreviewProvider {
  static var previews: some View {
    let viewModel = CalendarViewModel(with: SettingsStore(named: "Preview"))
    CalendarView()
      .environmentObject(viewModel)
  }
}
