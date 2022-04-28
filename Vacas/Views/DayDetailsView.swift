//
//  DayDetailsView.swift
//  Vacas
//
//  Created by Igor Blinnikov on 02.01.2022.
//

import SwiftUI

struct DayDetailsView: View {
  // TODO: Rename to something generic like `events`?
  // Introduce new view type that needs to be mapped into
  let day: Date
  var records: [ScheduleRecord]
  let canAdd = true
  
  @State private var addRecordFormShown = false
  @EnvironmentObject private var store: ScheduleRecordsStore
  
  var body: some View {
    VStack(spacing: 15) {
      HStack(alignment: .center) {
        Text("Records")
          .font(.title2.bold())
          .frame(maxWidth: .infinity, alignment: .leading)
        
        // TODO: Add proper animation for this button to disappear smoothly
        if canAdd && !addRecordFormShown {
          Button {
            withAnimation {
              addRecordFormShown = true
            }
          } label: {
            Image(systemName: "plus.circle")
          }
        }
      }
      .padding(.bottom, 20)
      
      if canAdd && addRecordFormShown {
        // TODO: Pass selected day as a param
        AddScheduleRecordView(day: day) { record in
          print(record)
          store.records.append(record)
          addRecordFormShown = false
        } onDismiss: {
          addRecordFormShown = false
        }
      }
      
      if records.isEmpty {
        Text("No records for the day")
      } else {
        ForEach(records) { record in
          // TODO: Add swipe gesture to delete record 
          ScheduleRecordView(record: record)
        }
      }
    }
  }
}

struct DayDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    let viewModel = CalendarViewModel(with: SettingsStore(named: "Preview"))
    let store = ScheduleRecordsStore()
    let records = Array(store.records.prefix(3))
    DayDetailsView(day: Date(), records: records)
      .environmentObject(viewModel)
  }
}
