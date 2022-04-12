//
//  Appearance+Extension.swift
//  Vacas
//
//  Created by Igor Blinnikov on 16.02.2022.
//

import SwiftUI

extension Appearance {
  func getColorScheme() -> ColorScheme? {
    switch self {
    case .light:
      return .light
    case .dark:
      return .dark
    case .system:
      return nil
    }
  }
}
