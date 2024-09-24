//
//  Stylesheet.Button.swift
//  Yassir iOS Task
//
//  Created by Islam Soliman on 23/09/2024.
//

import UIKit

extension Stylesheet.Button {

    static let unselectedFilter = Style<UIButton> {
        $0.backgroundColor = .white
        $0.setTitleColor(.black, for: .normal)
        $0.tintColor = .black
        $0.layer.cornerRadius = 17.5
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.black.cgColor
    }

    static let selectedFilter = Style<UIButton> {
        $0.backgroundColor = .systemBlue
        $0.tintColor = .white
        $0.layer.borderColor = UIColor.systemBlue.cgColor
    }
}
