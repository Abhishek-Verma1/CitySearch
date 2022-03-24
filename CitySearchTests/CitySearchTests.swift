//
//  CitySearchTests.swift
//  CitySearchTests
//
//  Created by Abhishek Verma on 23/02/2022.
//

import XCTest
@testable import CitySearch

class CitySearchTests: XCTestCase {
    
    var viewModel: CityListViewModel!
    var closureExpectation: XCTestExpectation!
    let numberOfCities = 5
    let expectationTimeout = 5.0
    
    lazy var dataProvider : DataProvider = {
        return DataProvider()
    }()
    
    override func setUp() {
        super.setUp()
        let service = CityListServiceImp(dataProvider: self.dataProvider)
        let viewModel1 = CityListViewModelImp(service: service)
        viewModel = viewModel1
        self.viewModel.viewDidLoad()
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
        closureExpectation = nil
    }
    
    func testNumberOfCities() {
        viewModel.showData = { [weak self] in
            guard let `self` = self else { return }
            XCTAssertEqual(self.viewModel.numberOfRowsInSection(section: 0), self.numberOfCities)
        }
    }
    
    func testFilteringForA() {
        closureExpectation = expectation(description: "Search for A Completed")
        viewModel.showData = { [weak self] in
            guard let `self` = self else { return }
            self.viewModel.filter("A")
            XCTAssertEqual(self.viewModel.numberOfRowsInSection(section: 0), 4)
            self.closureExpectation.fulfill()
        }
        wait(for: [closureExpectation], timeout: expectationTimeout)
    }
    
    func testFilteringForAl() {
        closureExpectation = expectation(description: "Search for Al Completed")
        viewModel.showData = { [weak self] in
            guard let `self` = self else { return }
            self.viewModel.filter("Al")
            XCTAssertEqual(self.viewModel.numberOfRowsInSection(section: 0), 2)
            self.closureExpectation.fulfill()
        }
        wait(for: [closureExpectation], timeout: expectationTimeout)
    }
    
    func testFilteringForAlb() {
        closureExpectation = expectation(description: "Search for Alb Completed")
        viewModel.showData = { [weak self] in
            guard let `self` = self else { return }
            self.viewModel.filter("Alb")
            XCTAssertEqual(self.viewModel.numberOfRowsInSection(section: 0), 1)
            self.closureExpectation.fulfill()
        }
        wait(for: [closureExpectation], timeout: expectationTimeout)
    }
    
    func testFilteringInvalidCity() {
        closureExpectation = expectation(description: "Search for Invalid City Completed")
        viewModel.showData = { [weak self] in
            guard let `self` = self else { return }
            self.viewModel.filter("invalid city")
            XCTAssertEqual(self.viewModel.numberOfRowsInSection(section: 0), 0)
            self.closureExpectation.fulfill()
        }
        wait(for: [closureExpectation], timeout: expectationTimeout)
    }
    
}
