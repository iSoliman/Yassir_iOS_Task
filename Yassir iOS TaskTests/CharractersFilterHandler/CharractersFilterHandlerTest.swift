//
//  CharractersFilterHandlerTest.swift
//  Yassir iOS TaskTests
//
//  Created by Islam Soliman on 21/09/2024.
//

import XCTest
@testable import Yassir_iOS_Task

final class CharractersFilterHandlerTest: XCTestCase {

    var characters: [CartoonCharacter]!
    var filter: CharractersFilterHandler!

    override func setUpWithError() throws {
        characters = ReadJson.readJSONFile(CharacterResponse.self, "CartoonCharacter_6").results
        filter = CharractersFilterHandler()
        filter?.addNewCharacter(characters)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAliveStatusFilter() throws {
        whenApplying(status: .alive)
        thenPresentedCharactersCount(2)
    }

    func whenApplying(status: CharacterStatus) {
        filter?.filterCharcterStatus(by: status)
    }

    func testApplyingAliveFilterTwice() throws {
        whenApplyingTwiceFilter(of: .alive)
        thenPresentedCharactersCount(6)
    }

    func whenApplyingTwiceFilter(of status: CharacterStatus) {
        filter?.filterCharcterStatus(by: status)
        filter?.filterCharcterStatus(by: status)
    }

    func testAddingNewCharactersAfterFilterWithAliveStatus() {
        whenAddingNewCharactersAfterFilter(with: .alive)
        thenPresentedCharactersCount(4)
    }

    func whenAddingNewCharactersAfterFilter(with status: CharacterStatus) {
        filter?.filterCharcterStatus(by: status)
        filter.addNewCharacter(characters)
    }

    func thenPresentedCharactersCount(_ expectedCount: Int) {
        XCTAssert(
            expectedCount == filter.presentedCharacter.count,
            "expectedCount \(expectedCount) not equals real count \(filter.presentedCharacter.count)")
    }
}
