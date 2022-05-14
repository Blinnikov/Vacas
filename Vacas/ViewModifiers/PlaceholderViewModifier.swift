//
//  PlaceholderViewModifier.swift
//  Vacas
//
//  Created by Igor Blinnikov on 14.05.2022.
//

import SwiftUI

extension View {
  func placeholder<Content: View>(
    when shouldShow: Bool,
    alignment: Alignment = .leading,
    @ViewBuilder placeholder: () -> Content) -> some View {
      
      ZStack(alignment: alignment) {
        placeholder().opacity(shouldShow ? 1 : 0)
        self
      }
    }
}
