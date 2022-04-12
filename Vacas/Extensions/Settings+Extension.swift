//
//  Settings+Extension.swift
//  Vacas
//
//  Created by Igor Blinnikov on 13.02.2022.
//

import SwiftUI

extension Settings {
  var color: Color {
    get {
      Color(rgbaColor: self.tintColor)
    }
    set {
      self.tintColor = RGBAColor(color: newValue)
    }
  }
}
