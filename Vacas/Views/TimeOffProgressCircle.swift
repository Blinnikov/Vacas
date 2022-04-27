//
//  TimeOffProgressCircle.swift
//  Vacas
//
//  Created by Igor Blinnikov on 27.04.2022.
//

import SwiftUI

struct TimeOffProgressCircle: View {
  let color: Color
  let progress: CGFloat
  let CircleLineWidth: CGFloat = 20
  let CircleBackgroundOpacity = 0.23
  let CircleShadow: CGFloat = 10
  
  var body: some View {
    ZStack {
      Circle()
        .stroke(color.opacity(CircleBackgroundOpacity), lineWidth: CircleLineWidth)
      
      Circle()
        .trim(from: 0, to: progress)
        .stroke(color, style: StrokeStyle(lineWidth: CircleLineWidth, lineCap: .round))
        .shadow(radius: CircleShadow)
        .rotationEffect(.degrees(-90))
    }
  }
}

struct TimeOffProgressCircle_Previews: PreviewProvider {
    static var previews: some View {
      TimeOffProgressCircle(color: .red, progress: 0.5)
    }
}
