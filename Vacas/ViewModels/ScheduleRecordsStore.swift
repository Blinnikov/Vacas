//
//  ScheduleRecordsStore.swift
//  Vacas
//
//  Created by Igor Blinnikov on 14.04.2022.
//

import Foundation

class ScheduleRecordsStore: ObservableObject {
  @Published var records: [ScheduleRecord] = ScheduleRecord.testData
}
