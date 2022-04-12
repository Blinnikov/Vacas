//
//  AddScheduleRecordView.swift
//  Vacas
//
//  Created by Igor Blinnikov on 11.04.2022.
//

import SwiftUI

struct AddScheduleRecordView: View {
  @State var record: ScheduleRecord = ScheduleRecord(title: "", date: Date(), type: .timeOff(.vacation))
  
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      HStack {
        Text(record.date, style: .time)
        Spacer()
        typeSelector
      }
      
      TextField("Enter a title", text: $record.title)
        .font(.title2.bold())
    }
    .padding(.vertical, 10)
    .padding(.horizontal)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(
      Color.bloodOrange
    )
  }
  
  var typeSelector: some View {
    Menu {
      Picker(selection: $record.type, label: Image(systemName: "plus")){
        Text("Overtime").tag(ScheduleChangeType.overtime)
        Text("Vacation").tag(ScheduleChangeType.timeOff(.vacation))
        Text("Holiday").tag(ScheduleChangeType.timeOff(.holiday))
        Text("Parental Leave").tag(ScheduleChangeType.timeOff(.parentalLeave))
        Text("Personal Time").tag(ScheduleChangeType.timeOff(.personalTime))
        Text("Sick Leave").tag(ScheduleChangeType.timeOff(.sickLeave))
      }
    } label: {
      let overlay = Circle().stroke(.white, lineWidth: 2).shadow(radius: 2)
      
      Circle()
        .fill(record.backgroundColor)
        .frame(width: 24, height: 24)
        .overlay(overlay)
    }
  }
}

struct AddScheduleRecordView_Previews: PreviewProvider {
  static var previews: some View {
    AddScheduleRecordView()
  }
}
