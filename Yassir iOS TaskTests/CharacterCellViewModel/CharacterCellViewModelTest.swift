//
//  CharacterCellViewModelTest.swift
//  Yassir iOS TaskTests
//
//  Created by Islam Soliman on 24/09/2024.
//

import XCTest
@testable import Yassir_iOS_Task

final class CharacterCellViewModelTest: XCTestCase {

    var viewModel: CharacterCellViewModel!

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewModelWithAliveStatus() throws {
        viewModel = CharacterCellViewModel(status: "Alive")
        XCTAssert(viewModel.styler is BabyBlueCharacterStyling)
    }

    func testViewModelWithUnknownStatus() throws {
        viewModel = CharacterCellViewModel(status: "unknown")
        XCTAssert(viewModel.styler is WhiteCharacterStyling)
    }

    func testViewModelWithDeadStatus() throws {
        viewModel = CharacterCellViewModel(status: "Dead")
        XCTAssert(viewModel.styler is PinkCharacterStyling)
    }

    func testViewModelWithWrongStatus() throws {
        viewModel = CharacterCellViewModel(status: "***")
        XCTAssert(viewModel.styler is WhiteCharacterStyling)
    }
}
