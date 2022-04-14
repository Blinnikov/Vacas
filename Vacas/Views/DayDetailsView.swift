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
  let records: [ScheduleRecord]
  let canAdd = true
  
  @State private var addRecordFormShown = false
  
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
            Image(systemName: "plus.square.on.square")
//            Image(systemName: "calendar.badge.plus")
//            Image(systemName: "plus.circle")
          }
        }
      }
      .padding(.bottom, 20)
      
      if canAdd && addRecordFormShown {
        AddScheduleRecordView {
          addRecordFormShown = false
        }
      }
      
      if records.isEmpty {
        Text("No records for the day")
      } else {
        ForEach(records) { record in
          ScheduleRecordView(record: record)
        }
      }
    }
  }
}

struct DayDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    let viewModel = CalendarViewModel(with: SettingsStore(named: "Preview"))
    let records = Array(ScheduleRecord.testData.prefix(3))
    DayDetailsView(records: records)
      .environmentObject(viewModel)
  }
}
