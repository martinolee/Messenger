//
//  StringExtensionsTests.swift
//  MessengerTests
//
//  Created by Soohan Lee on 2020/06/17.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

@testable import Messenger

import XCTest

class StringExtensionsTests: XCTestCase {
  
  func testIsValidEmail() {
    let validEmail = "soohan.m.lee@gmail.com"
    let invalidEmail = "This is invalid email"
    
    XCTAssert(validEmail.isValidEmail == true, "It has invalid email")
    
    XCTAssert(invalidEmail.isValidEmail == false, "It has valid email")
  }
  
  func testHasWhiteSpace() {
    let stringWithWhiteSpace = " String with white space "
    let stringWithoutWhiteSpace = "String without white space"
    
    XCTAssert(stringWithWhiteSpace.hasWhiteSpace == true, "It has not white space")
    
    XCTAssert(stringWithoutWhiteSpace.hasWhiteSpace == false, "It has white space")
  }
}
