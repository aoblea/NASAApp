//
//  NASA_AppTests.swift
//  NASA AppTests
//
//  Created by Arwin Oblea on 1/9/20.
//  Copyright © 2020 Arwin Oblea. All rights reserved.
//

import XCTest
@testable import NASA_App // import app to be able to do tests

class NASA_AppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
  
  func testMarsPhotos() {
    let client = NASAClient()
    
    let expect = expectation(description: "Completion handler has succeeded")
    var retrievedObjects: [Photo] = []
    var responseError: Error?
    
    client.getMarsPhotos { (results) in
      switch results {
      case .success(let marsPhotos):
        retrievedObjects = marsPhotos.photos
        expect.fulfill() // Completion has succeeded
      case .failure(let error):
        responseError = error
      }
    }
    
    wait(for: [expect], timeout: 5) // 5 seconds to wait for a list of expectations
    
    XCTAssertNotNil(retrievedObjects, "If this succeed, it means that it contains marsphotos.photos")
    XCTAssertNil(responseError, "If this succeed, it means that there were no errors.")
  }

  func testEarthImagery() {
    let client = NASAClient()
    
    let expect = expectation(description: "Completion handler has succeeded")
    var retrievedObject: EarthImagery?
    var responseError: Error?
    
    var testLatitude: String = "40.725058"
    var testLongitude: String = "73.999037"
    
    client.getEarthImagery(latitude: testLatitude, longitude: testLongitude) { (results) in
      switch results {
      case .success(let earthImagery):
        retrievedObject = earthImagery
        expect.fulfill()
      case .failure(let error):
        responseError = error
      }
    }
    
    wait(for: [expect], timeout: 5)
    
    XCTAssertNotNil(retrievedObject, "If this succeed, client has retrieved an earthimagery object")
    XCTAssertNil(responseError, "If this succeed, it means that there were no errors.")
  }
  
// using this for testing purposes
//  https://api.nasa.gov/planetary/earth/imagery/?lat=40.725058&lon=-73.999037&api_key=xCieywUphIaacqI9FG4hkAtpdTClyiyE3lIO9a6F

}
