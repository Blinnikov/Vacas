//
//  DayDetailsView.swift
//  Vacas
//
//  Created by Igor Blinnikov on 02.01.2022.
//

import SwiftUI

struct DayDetailsView: View {
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
          store.records.append(record)
          addRecordFormShown = false
        } onDismiss: {
          addRecordFormShown = false
        }
      }
      
      if records.isEmpty {
        Text("No records for the day")
      } else {
//        ForEachImplementation(records: records)
        ListImplementation(records: records)
      }
    }
  }
  
  func ForEachImplementation(records: [ScheduleRecord]) -> some View {
    ForEach(records) { record in
      // TODO: Add swipe gesture to delete record
      ScheduleRecordView(record: record) { record in
        print(record)
      }
    }
  }
  
  func ListImplementation(records: [ScheduleRecord]) -> some View {
    List {
      ForEach(records) { record in
        ScheduleRecordView(record: record)
          .listRowSeparator(.hidden)
          .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
      }
      .swipeActions(edge: .trailing) {
        Button(role: .destructive) {
//          store.delete(message)
        } label: {
          Label("Delete", systemImage: "trash")
            .tint(.red)
            .foregroundColor(.red)
        }
      }
    }
    .listStyle(.plain)
    // To make `List` within `ScrollView` work
    // https://stackoverflow.com/questions/58959475/list-hides-when-adding-in-scrollview-swiftui
    .scaledToFit()
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
