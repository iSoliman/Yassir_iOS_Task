//
//  CharacterListFetcher.swift
//  Yassir iOS Task
//
//  Created by Islam Soliman on 21/09/2024.
//

import Combine

final class CharacterListFetcher {

    //MARK: - Internal
    var canLoadNextPage = true

    //MARK: - Private
    private var currentPage: Int
    private var networkManager: NetworkManager
    private var cancellables = Set<AnyCancellable>()

    //MARK: - Initializer
    init(currentPage: Int = 1, networkManager: NetworkManager = NetworkManagerImp.shared) {
        self.currentPage = currentPage
        self.networkManager = networkManager
    }

    //MARK: - Internal functions
    func fetchCharacters() async throws -> [CartoonCharacter] {
        let characterResponse = try await networkManager.fetchData(
            CharacterResponse.self,
            with: CharacterListRequestBuilder(currentPage: currentPage))
        currentPage += 1
        canLoadNextPage = characterResponse.info.next != nil
        return characterResponse.results
    }
}
