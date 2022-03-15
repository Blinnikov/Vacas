//
//  DeveloperInfoView.swift
//  Vacas
//
//  Created by Igor Blinnikov on 14.03.2022.
//

import SwiftUI

struct DeveloperInfoView: View {
  let dateService = DateService()
  
  var body: some View {
    VStack {
      HStack {
        Text("Developer Info")
          .font(.title)
          .padding()
        
        Spacer()
      }
      
      HStack {
        Text("Working days this year:")
        Spacer()
        Text("\(dateService.workingDaysThisYear())")
      }
      .padding()
      
      Spacer()
    }
    
//      .frame(minWidth: 300, minHeight: 350)
  }
}

struct DeveloperInfoView_Previews: PreviewProvider {
  static var previews: some View {
    DeveloperInfoView()
  }
}
