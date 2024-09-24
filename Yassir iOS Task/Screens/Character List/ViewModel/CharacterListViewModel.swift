//
//  CharacterListViewModel.swift
//  Yassir iOS Task
//
//  Created by Islam Soliman on 21/09/2024.
//

import Combine

final class CharacterListViewModel {

    //MARK: Internal
    @Published var characters = [CartoonCharacter]()
    @Published var errorMessage: String?

    //MARK: Private
    private let fetcher: CharacterListFetcher
    private let filterHandler: CharractersFilterHandler
    private let asyncSchedulerFactory: AsyncSchedulerFactory

    private var cancellables = Set<AnyCancellable>()

    //MARK: Initializer
    init(
        fetcher: CharacterListFetcher = .init(),
        filterHandler: CharractersFilterHandler = .init(),
        asyncSchedulerFactory: AsyncSchedulerFactory = TaskAsyncSchedulerFactory()) {
            self.fetcher = fetcher
            self.filterHandler = filterHandler
            self.asyncSchedulerFactory = asyncSchedulerFactory
            filterHandler.$presentedCharacter
                .sink { [weak self] chars in
                    self?.characters = chars
                }
                .store(in: &cancellables)
    }

    //MARK: Internal Functions
    func requestCharacters() {
        asyncSchedulerFactory.create { [unowned self] in
            guard fetcher.canLoadNextPage else { return }
            do {
                let characters = try await fetcher.fetchCharacters()
                await fetchedNewCharacters(characters: characters)
            } catch {
                if filterHandler.hasNoCharacters {
                    errorMessage = error.localizedDescription
                }
            }
        }
    }

    func fiter(by status: CharacterStatus) {
        filterHandler.filterCharcterStatus(by: status)
    }

    //MARK: Private Functions
    @MainActor
    private func fetchedNewCharacters(characters: [CartoonCharacter]) {
        filterHandler.addNewCharacter(characters)
    }
}
