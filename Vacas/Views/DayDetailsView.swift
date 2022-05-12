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
  
  @State private var shownRecords = Set<UUID>()
  @State private var addRecordFormShown = false
  @EnvironmentObject private var store: ScheduleRecordsStore
  
  private func isRecordHidden(_ record: ScheduleRecord) -> Bool {
    !shownRecords.contains(record.id)
  }
  
  private func hideRecord(_ record: ScheduleRecord) {
    shownRecords.remove(record.id)
  }
  
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
          Task {
            await store.add(record)
            addRecordFormShown = false
          }
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
    .onAppear {
      for record in records {
        shownRecords.insert(record.id)
      }
    }
  }
  
  @State private var alertShown = false
  @State private var confirmationDialogShown = false
  @State private var itemToDelete: ScheduleRecord? = nil // Because closure in ForEach works strange
  private let warningTitle = "Are you sure?"
  
  func ForEachImplementation(records: [ScheduleRecord]) -> some View {
    ForEach(records) { record in
      if isRecordHidden(record) {
        Color.clear
      }
      else {
        ScheduleRecordView(record: record) { r in
          alertShown = true
  //        confirmationDialogShown = true
          itemToDelete = r
        }
        .alert(warningTitle, isPresented: $alertShown) {
          alertButtons()
        }
        .confirmationDialog(warningTitle, isPresented: $confirmationDialogShown) {
          alertButtons()
        }
      }
    }
  }
  
  func ListImplementation(records: [ScheduleRecord]) -> some View {
    List {
      ForEach(records) { record in
        if isRecordHidden(record) {
          Color.clear
        } else {
          ScheduleRecordView(record: record)
          // To remove row separators
          // https://stackoverflow.com/questions/56553672/how-to-remove-the-line-separators-from-a-list-in-swiftui-without-using-foreach
            .listRowSeparator(.hidden)
          // To remove row paddings added by List
          // https://stackoverflow.com/questions/56614080/how-to-remove-the-left-and-right-padding-of-a-list-in-swiftui
            .listRowInsets(EdgeInsets(top: 6, leading: 0, bottom: 6, trailing: 0))
            .swipeActions(edge: .trailing) {
              Button(role: .destructive) {
                //              alertShown = true
                confirmationDialogShown = true
                itemToDelete = record
              } label: {
                Label("Delete", systemImage: "trash")
                  .tint(.red)
                  .foregroundColor(.red)
              }
            }
            .alert(warningTitle, isPresented: $alertShown) {
              alertButtons()
            }
            .confirmationDialog(warningTitle, isPresented: $confirmationDialogShown) {
              alertButtons()
            }
        }
      }
    }
    .listStyle(.plain)
    // To make `List` within `ScrollView` work
    // https://stackoverflow.com/questions/58959475/list-hides-when-adding-in-scrollview-swiftui
    .scaledToFit()
  }
  
  @ViewBuilder
  func alertButtons() -> some View {
    Button("Delete", role: .destructive) {
      if let itemToDelete = itemToDelete {
        // TODO: `withAnimation` doesn't work alongside with `Task`, need to workaround this
        withAnimation {
          hideRecord(itemToDelete)
          Task {
            // Optimistic removal
            let item = await store.removeAsync(itemToDelete)
            if item != nil {
              print("Removed: \(item!)")
            }
          }
        }
      }
      itemToDelete = nil
    }
    
    Button("Cancel", role: .cancel) {
      itemToDelete = nil
    }
  }
}

struct DayDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    let viewModel = CalendarViewModel(with: SettingsStore(named: "Preview"))
    let store = ScheduleRecordsStore(named: "Preview")
    DayDetailsView(day: Date(), records: store.first(3))
      .environmentObject(viewModel)
  }
}
