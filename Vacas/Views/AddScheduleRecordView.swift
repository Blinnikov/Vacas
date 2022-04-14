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
      
      HStack {
        Spacer()
        
        Button {
          
        } label: {
          buttonLabel(systemName: "calendar.badge.plus")
        }
        .padding(.trailing, 4)
        
        Button {
          
        } label: {
          buttonLabel(systemName: "xmark", discard: true)
        }
        
      }
    }
    .padding(.vertical, 10)
    .padding(.horizontal)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(
      RoundedRectangle(cornerRadius: 10)
        .fill(Color.snow)
        .shadow(radius: 5)
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
        .frame(width: DrawingConstants.CircleButtonSize, height: DrawingConstants.CircleButtonSize)
        .overlay(overlay)
    }
  }
  
  func buttonLabel(systemName: String, discard: Bool = false) -> some View {
    
    ZStack {
      Circle()
        .fill(.white)
        .frame(width: DrawingConstants.CircleButtonSize, height: DrawingConstants.CircleButtonSize)
        .shadow(radius: 2)
      
      Image(systemName: systemName)
        .foregroundColor(discard ? .red : .accentColor)
    }
  }
  
  private struct DrawingConstants {
    static let CircleButtonSize: CGFloat = 34
  }
}

struct AddScheduleRecordView_Previews: PreviewProvider {
  static var previews: some View {
    AddScheduleRecordView()
  }
}
