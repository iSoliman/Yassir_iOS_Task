//
//  CharacterListFetcherTest.swift
//  Yassir iOS TaskTests
//
//  Created by Islam Soliman on 23/09/2024.
//

import XCTest
@testable import Yassir_iOS_Task

final class CharacterListFetcherTest: XCTestCase {
    
    var fitcher: CharacterListFetcher!
    var networkManager: NetworkManagerMock!
    var fetchedCharacters: [CartoonCharacter]!
    
    override func setUpWithError() throws {
        networkManager = .init(jsonFile: "CartoonCharacter_6")
        fitcher = CharacterListFetcher(networkManager: networkManager)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchingCharactersSucceessfully() {
        whenFetchingCharacters(withSuccess: true)
        thenExpectedCharactersCount(6)
        andExpeectedCurrentPage(2)
    }

    func testFetchingCharactersFailed() {
        whenFetchingCharacters(withSuccess: false)
        thenExpectedNilCharacters()
        andExpeectedCurrentPage(1)
    }

    func whenFetchingCharacters(withSuccess isSucceed: Bool) {
        networkManager.shouldSucceed = isSucceed
        let expectation = expectation(description: "Async function should complete")
        Task {
            fetchedCharacters = try? await fitcher.fetchCharacters()
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func thenExpectedCharactersCount(_ expected: Int) {
        XCTAssert(
            expected == fetchedCharacters.count,
            "expected characters count: \(expected) not equals actual characters count\(fetchedCharacters.count)")
    }

    func thenExpectedNilCharacters() {
        XCTAssertNil(fetchedCharacters)
        
    }

    func andExpeectedCurrentPage(_ expectedPage: Int) {
        XCTAssert(expectedPage == getRealCurrentPage())
    }

    func getRealCurrentPage() -> Int {
        let mirror = Mirror(reflecting: fitcher!)
        let value = mirror.children.first(where: { $0.label == "currentPage" })?.value as! Int
        return value
    }
}
