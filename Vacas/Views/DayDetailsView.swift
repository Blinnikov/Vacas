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
  
  var body: some View {
    VStack(spacing: 15) {
      Text("Records")
        .font(.title2.bold())
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 20)
//        .padding(.vertical, 20)
      
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
    DayDetailsView(records: ScheduleRecord.testData)
      .environmentObject(viewModel)
  }
}
