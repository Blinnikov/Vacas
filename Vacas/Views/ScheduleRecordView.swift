//
//  RecordView.swift
//  Vacas
//
//  Created by Igor Blinnikov on 02.01.2022.
//

import SwiftUI

struct ScheduleRecordView: View {
  let record: ScheduleRecord
  
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(record.date.addingTimeInterval(CGFloat.random(in: 0...5000)), style: .time)
      
      Text(record.title)
        .font(.title2.bold())
    }
    .padding(.vertical, 10)
    .padding(.horizontal)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(
      background(for: record)
        .cornerRadius(10)
    )
  }
  
  func background(for record: ScheduleRecord) -> some View {
    let defaultColor = Color.purple
      .opacity(0.5)
    
    switch record.type {
    case .overtime:
      return defaultColor
    case .timeOff(let t):
      switch t {
      case .vacation:
        return Color.peach
      default:
        return defaultColor
      }
    }
  }
}

struct RecordView_Previews: PreviewProvider {
  static var previews: some View {
    ScheduleRecordView(record: ScheduleRecord.testData.first!)
  }
}
