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
          store.add(record)
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
  
  @State private var isShowingAlert = false
  
  func ForEachImplementation(records: [ScheduleRecord]) -> some View {
    ForEach(records) { record in
      // TODO: Add swipe gesture to delete record
      ScheduleRecordView(record: record) { record in
        // TODO: UI is not updated
        // TODO: Add warning alert before deletion
        isShowingAlert = true
      }
      .alert("Do you really want to delete?", isPresented: $isShowingAlert) {
        Button("Delete", role: .destructive) {
          withAnimation {
            store.remove(record)
            print("Removed: \(record)")
          }
        }
      }
    }
  }
  
  func ListImplementation(records: [ScheduleRecord]) -> some View {
    List {
      ForEach(records) { record in
        ScheduleRecordView(record: record)
        // To remove row separators
        // https://stackoverflow.com/questions/56553672/how-to-remove-the-line-separators-from-a-list-in-swiftui-without-using-foreach
          .listRowSeparator(.hidden)
        // To remove row paddings added by List
        // https://stackoverflow.com/questions/56614080/how-to-remove-the-left-and-right-padding-of-a-list-in-swiftui
          .listRowInsets(EdgeInsets(top: 6, leading: 0, bottom: 6, trailing: 0))
      }
      .swipeActions(edge: .trailing) {
        Button(role: .destructive) {
//          store.remove(record)
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
    DayDetailsView(day: Date(), records: store.first(3))
      .environmentObject(viewModel)
  }
}
