//
//  VacasTests.swift
//  VacasTests
//
//  Created by Igor Blinnikov on 01.03.2022.
//

import XCTest
@testable import Vacas

class VacasTests: XCTestCase {
  let dateService = DateService()
  
  func testGetToday() {
    let today = Date()
    
    assert(dateService.getToday().inSameDayAs(today))
  }
  
  func testFirstDayOfCurrentYear() {
    let day = dateService.firstDayOfCurrentyear
    XCTAssertEqual(day, Date.from("2022-01-01"))
  }
  
  func testFirstDayOf2021() {
    let day = dateService.firstDay(of: 2021)
    assert(day == Date.from("2021-01-01"))
  }
  
  func testFirstDayOf2022() {
    let day = dateService.firstDay(of: 2022)
    assert(day == Date.from("2022-01-01"))
  }
  
  func testWorkingDaysCount() {
    let march1 = Date.from("2022-03-01")
    let march8 = Date.from("2022-03-08")
    
    let count = dateService.workingDays(between: march1, and: march8)
    XCTAssertEqual(count, 5)
  }
}
