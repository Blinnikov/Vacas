//
//  Markers.swift
//  Vacas
//
//  Created by Igor Blinnikov on 02.04.2022.
//

import SwiftUI

struct Markers: View {
  private let recordsToShowCount = 3
  
  private let records: ArraySlice<ScheduleRecord>
  private let hasMore: Bool
  private let totalCount: Int
  
  init(records: [ScheduleRecord]) {
    self.hasMore = records.count > recordsToShowCount
    self.records = records.prefix(recordsToShowCount)
    self.totalCount = hasMore ? recordsToShowCount + 1 : records.count
  }
  
  @EnvironmentObject var viewModel: CalendarViewModel
  
  var body: some View {
    if records.isEmpty {
      EmptyView()
    }
    
    ZStack {
      let overlay = Circle().stroke(.white, lineWidth: 1.5).shadow(radius: 2)
      
      ForEach(0..<records.count, id: \.self) { index in
        Circle()
          .fill(viewModel.backgroundColor(for: records[index]))
          .frame(width: 8, height: 8)
          .overlay(overlay)
          .zIndex(zIndex(for: index))
          .offset(x: offset(for: index, in: totalCount))
      }
      
      if hasMore {
        Circle()
          .fill(Color.white)
          .frame(width: 7, height: 7)
          .overlay(overlay)
          .zIndex(zIndexForHasMoreMarker)
          .offset(x: offsetForHasMoreMarker)
      }
    }
    
  }
  
  // TODO: Add UT?
  private func offset(for index: Int, in count: Int) -> CGFloat {
    let offsetValue: CGFloat = 15
    let itemOffsetValue = offsetValue / CGFloat(count)
    let padding = count % 2 == 0 ? itemOffsetValue / 2 : 0
    let initialOffset = -1 * CGFloat(count / 2) * itemOffsetValue + padding
    
    return initialOffset + itemOffsetValue * CGFloat(index)
  }
  
  private var offsetForHasMoreMarker: CGFloat {
    offset(for: recordsToShowCount, in: recordsToShowCount + 1)
  }
  
  private func zIndex(for index: Int) -> Double {
    -Double(index)
  }
  
  private var zIndexForHasMoreMarker: Double {
    zIndex(for: recordsToShowCount)
  }
}

struct Markers_Previews: PreviewProvider {
  static var previews: some View {
    let viewModel = CalendarViewModel(with: SettingsStore(named: "Preview"))
    Markers(records: ScheduleRecord.testData.suffix(7))
      .environmentObject(viewModel)
  }
}
