//
//  CharacterListViewModelTest.swift
//  Yassir iOS TaskTests
//
//  Created by Islam Soliman on 23/09/2024.
//

import Combine
import XCTest
@testable import Yassir_iOS_Task

class CharacterListViewModelTest: XCTestCase {

    var charactersViewModel: CharacterListViewModel!
    var fetcher: CharacterListFetcher!
    var networkManager: NetworkManagerMock!
    var asyncSchedulerFactorySpy: AsyncSchedulerFactorySpy!

    override func setUpWithError() throws {
        asyncSchedulerFactorySpy = AsyncSchedulerFactorySpy()
        networkManager = NetworkManagerMock(jsonFile: "CartoonCharacter_6")
        fetcher = CharacterListFetcher(networkManager: networkManager)
        charactersViewModel = CharacterListViewModel(
            fetcher: fetcher,
            asyncSchedulerFactory: asyncSchedulerFactorySpy)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchCharactersSuccessfully() async {
        await whenFetchingCharacters(withSuccess: true)
        thenCharacterCountEquals(6)
    }

    func testFetchCharactersFailed() async {
        await whenFetchingCharacters(withSuccess: false)
        thenErrorMessageEquals(NetworkManagerMock.errorMsg)
    }

    func testFilteredSuccessfullyFetchedCharacters() async {
        await whenFilteredSuccessfullyFetchedCharacters()
        thenCharacterCountEquals(2)
    }

    func whenFilteredSuccessfullyFetchedCharacters() async {
        await whenFetchingCharacters(withSuccess: true)
        charactersViewModel.fiter(by: .alive)
    }

    func whenFetchingCharacters(withSuccess isSucceed: Bool) async {
        networkManager.shouldSucceed = isSucceed
        charactersViewModel.requestCharacters()
        await asyncSchedulerFactorySpy.executeLast()
    }

    func testFailFetchingSecondPage() async {
        await whenFailFetchingSecondPage()
        thenCharacterCountEquals(6)
        andErrorMessageIsNil()
        
    }

    func whenFailFetchingSecondPage() async {
        networkManager.shouldSucceed = true
        charactersViewModel.requestCharacters()
        await asyncSchedulerFactorySpy.executeLast()
        networkManager.shouldSucceed = false
        charactersViewModel.requestCharacters()
        await asyncSchedulerFactorySpy.executeLast()
    }

    func testTryToFetchCharractersPastLastPage() async {
        await whenTryToFetchCharractersPastLastPage()
        thenCharacterCountEquals(0)
    }

    func whenTryToFetchCharractersPastLastPage() async {
        fetcher.canLoadNextPage = false
        await whenFetchingCharacters(withSuccess: true)
    }

    func thenCharacterCountEquals(_ expectedCount: Int) {
        XCTAssert(
            expectedCount == charactersViewModel.characters.count,
            "expected characters count: \(expectedCount), not equal real character count: \(charactersViewModel.characters.count)")
    }

    func thenErrorMessageEquals(_ expectedErrorMsg: String) {
        XCTAssert(
            expectedErrorMsg == charactersViewModel.errorMessage,
            "expected error message: \(expectedErrorMsg), not equal real error message: \(charactersViewModel.errorMessage ?? "Null")")
    }

    func andErrorMessageIsNil() {
        XCTAssertNil(charactersViewModel.errorMessage)
    }
}
