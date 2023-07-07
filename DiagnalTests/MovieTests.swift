//
//  MovieTests.swift
//  DiagnalTests
//
//  Created by Avinash Thakur on 02/07/23.
//

import XCTest
import Diagnal

final class MovieTests: XCTestCase {

    /// Function tests the content fetched for given random json file name.
    func testExample() throws {
        let fileName = "Abc"
        let file = Utitity.loadJson(fileName: fileName)
        XCTAssert(file != nil, "File loading test passed")
    }
    

    /// Function tests the content fetched for given json file name with Page 1 content
    func testMoviePage1() throws {
        let fileName = "CONTENTLISTINGPAGE-PAGE1"
        let file = Utitity.loadJson(fileName: fileName)
        XCTAssert(file != nil, "File loading test passed")
    }
    
    /// Function tests the content fetched for given json file name with Page 2 content
    func testMoviePage2() throws {
        let fileName = "CONTENTLISTINGPAGE-PAGE2"
        let file = Utitity.loadJson(fileName: fileName)
        XCTAssert(file != nil, "File loading test passed")
    }
    
    /// Function tests the content fetched for given json file name with Page 3 content
    func testMoviePage3() throws {
        let fileName = "CONTENTLISTINGPAGE-PAGE3"
        let file = Utitity.loadJson(fileName: fileName)
        XCTAssert(file != nil, "File loading test passed")
    }
    
    /// Function tests the content fetched for given json file name with Page 4 content
    func testMoviePage4() throws {
        let fileName = "CONTENTLISTINGPAGE-PAGE4"
        let file = Utitity.loadJson(fileName: fileName)
        XCTAssert(file != nil, "File loading test passed")
    }

}
