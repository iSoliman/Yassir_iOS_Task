//
//  CharacterListViewController.swift
//  Yassir iOS Task
//
//  Created by Islam Soliman on 21/09/2024.
//

import Combine
import SwiftUI
import UIKit

class CharacterListViewController: UIViewController {

    //MARK: @IBOutlet
    @IBOutlet private var charactersTableView: UITableView!
    @IBOutlet private var charactersViewContainer: UIView!
    @IBOutlet private var errorLabel: UILabel!
    @IBOutlet private var errorView: UIView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var filterButtons: [UIButton]!

    //MARK: Private
    private let cellId = "CharacterTableViewCellID"
    private let viewModel = CharacterListViewModel()

    private var characters = [CartoonCharacter]()
    private var cancellables = Set<AnyCancellable>()

    //MARK: Internal Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureTableView()
        configureFilterButtons()
        configureListeners()
        requestCharacters()
    }

    //MARK: Private Functions
    private func configureNavBar() {
        navigationController?.navigationBar.isHidden = true
    }

    private func configureTableView() {
        charactersTableView.dataSource = self
        charactersTableView.delegate = self
        charactersTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }

    private func configureFilterButtons() {
        filterButtons.forEach { $0.apply(Stylesheet.Button.unselectedFilter) }
    }

    private func configureListeners() {
        viewModel.$characters
            .dropFirst()
            .sink { [weak self] characters in
                self?.characters = characters
                self?.charactersTableView.reloadData()
                self?.showCharacters()
            }
            .store(in: &cancellables)

        viewModel.$errorMessage
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                self?.errorLabel.text = errorMessage
                self?.showErrorMessage()
            }
            .store(in: &cancellables)
    }

    private func requestCharacters() {
        showLoaderView()
        viewModel.requestCharacters()
    }

    private func requestMoreCharacters() {
        viewModel.requestCharacters()
    }

    private func showCharacters() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        errorView.isHidden = true
        charactersViewContainer.isHidden = false
    }

    private func showErrorMessage() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        errorView.isHidden = false
        charactersViewContainer.isHidden = true
    }

    private func showLoaderView() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        errorView.isHidden = true
        charactersViewContainer.isHidden = true
    }

    //MARK: Internal functions
    @IBAction func filterAliveCharacters(_ sender: UIButton) {
        viewModel.fiter(by: .alive)
    }

    @IBAction func filterUnknownCharacters(_ sender: UIButton) {
        viewModel.fiter(by: .unknown)
    }

    @IBAction func filterDeadCharacters(_ sender: UIButton) {
        viewModel.fiter(by: .dead)
    }

    @IBAction func retry(_ sender: UIButton) {
        requestCharacters()
    }
}

//MARK: UITableViewDataSource
extension CharacterListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let swiftUIView = CharacterCell(character: characters[indexPath.row])
        let hostingController = UIHostingController(rootView: swiftUIView)
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(hostingController.view)
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor)
        ])
        return cell
    }
}

//MARK: UITableViewDelegate
extension CharacterListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsView = CharacterDetails(character: characters[indexPath.row]) { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        let detailsController = UIHostingController(rootView: detailsView)
        navigationController?.pushViewController(detailsController, animated: true)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == characters.count {
            requestMoreCharacters()
        }
    }
}
