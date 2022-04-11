//
//  AddScheduleRecordView.swift
//  Vacas
//
//  Created by Igor Blinnikov on 11.04.2022.
//

import SwiftUI

struct AddScheduleRecordView: View {
  @Binding var record: ScheduleRecord
  
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(record.date, style: .time)
      
      Picker(selection: $record.type){
        Text("Overtime").tag(ScheduleChangeType.overtime)
        Text("Vacation").tag(ScheduleChangeType.timeOff(.vacation))
        Text("Holiday").tag(ScheduleChangeType.timeOff(.holiday))
        Text("Parental Leave").tag(ScheduleChangeType.timeOff(.parentalLeave))
        Text("Personal Time").tag(ScheduleChangeType.timeOff(.personalTime))
        Text("Sick Leave").tag(ScheduleChangeType.timeOff(.sickLeave))
      } label: {
        Image(systemName: "plus")
      }
      .pickerStyle(MenuPickerStyle())
      .accentColor(.white)
      .font(.title.bold())
//      .tint(.red)
      .padding(4)
      .background(.gray)
      .cornerRadius(15)
      
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
}

struct AddScheduleRecordView_Previews: PreviewProvider {
  static var previews: some View {
    let record = ScheduleRecord(title: "", date: Date(), type: .timeOff(.vacation))
    AddScheduleRecordView(record: Binding.constant(record))
  }
}
