//
//  FilterButtonsUIHandler.swift
//  Yassir iOS Task
//
//  Created by Islam Soliman on 23/09/2024.
//

import UIKit

class FilterButtonsUIHandler: UIView {

    @IBOutlet private var buttons: [UIButton]!
    var selectedButton: UIButton?

    @IBAction func tapFilterButton(_ sender: UIButton) {
        if sender == selectedButton {
            deselect(button: sender)
            selectedButton = nil
        } else {
            deselect(button: selectedButton)
            select(button: sender)
            selectedButton = sender
        }
    }

    private func select(button: UIButton) {
        button.apply(Stylesheet.Button.selectedFilter)
    }

    private func deselect(button: UIButton?) {
        button?.apply(Stylesheet.Button.unselectedFilter)
    }
}
