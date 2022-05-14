//
//  AddScheduleRecordView.swift
//  Vacas
//
//  Created by Igor Blinnikov on 11.04.2022.
//

import SwiftUI

struct AddScheduleRecordView: View {
  @State private var record: ScheduleRecord
  @State private var isValid: Bool = true
  
  private let onSave: (_ record: ScheduleRecord) -> Void
  private let onDismiss: () -> Void
  
  init(day: Date, onSave: @escaping (ScheduleRecord) -> Void, onDismiss: @escaping () -> Void) {
    self._record = State(initialValue: ScheduleRecord(title: "", date: day, type: .timeOff(.vacation)))
    self.onSave = onSave
    self.onDismiss = onDismiss
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      HStack {
        Text(record.date, style: .time)
        Spacer()
        typeSelector
      }
      
      let placeholderText = "Enter a title"
      TextField(placeholderText, text: $record.title)
        .font(.title2.bold())
        .onChange(of: record.title) { newValue in checkValidation() }
        .placeholder(when: record.title.isEmpty) {
          Text(placeholderText)
            .font(.title2.bold())
            .foregroundColor(isValid ? .clear : .red)
        }
      
      HStack {
        Spacer()
        
        Button {
          if checkValidation() {
            onSave(record)
          }
        } label: {
          buttonLabel(systemName: "calendar.badge.plus")
            .disabled(isValid == false)
        }
        .padding(.trailing, 4)
        
        Button {
          withAnimation {
            onDismiss()
          }
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
        // TODO: Rewrite using `ForEach`
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
  
  @discardableResult
  private func checkValidation() -> Bool {
    isValid = !record.title.isEmpty
    return isValid
  }
  
  private struct DrawingConstants {
    static let CircleButtonSize: CGFloat = 34
  }
}

struct AddScheduleRecordView_Previews: PreviewProvider {
  static var previews: some View {
    AddScheduleRecordView(day: Date(), onSave: { _ in }, onDismiss: {})
  }
}
