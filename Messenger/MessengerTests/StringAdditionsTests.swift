//
//  StringAdditionsTests.swift
//  MessengerTests
//
//  Created by Soohan Lee on 2020/06/17.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

@testable import Messenger

import XCTest

class StringAdditionsTests: XCTestCase {
  func testIsValidEmail() {
    let validEmail = "soohan.m.lee@gmail.com"
    let invalidEmail = "This is invalid email"
    
    XCTAssert(validEmail.isValidEmail == true, "It has invalid email")
    
    XCTAssert(invalidEmail.isValidEmail == false, "It has valid email")
  }
}
